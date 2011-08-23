class clone_app {
  require git
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    cwd => '/vagrant',
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
  }
  
  exec {'git_clone':
    creates => '/vagrant/.git',
    command => 'git clone git://github.com/one-click-orgs.git /vagrant',
  }
}

class gem_ext_dependencies {
  package {'gem_ext_dependencies':
    name => ['libxslt-dev', 'libxml2-dev', 'libmysqlclient-dev'],
    ensure => installed,
  }
}

class app_setup {
  include mysql
  include ruby
  
  require bundler
  require gem_ext_dependencies
  
  Exec {
    path => ['/home/vagrant/.rbenv/versions/1.9.2-p290/bin', '/usr/local/bin', '/usr/bin', '/bin'],
    logoutput => true,
    cwd => '/vagrant',
  }
  
  exec {'bundle_install':
    command => 'bundle install --system',
    timeout => 6000,
    require => Exec['update_rubygems'],
    unless => 'bundle check',
  }
  
  exec {'generate_config':
    command => 'bundle exec rake oco:generate_config',
    require => Exec['bundle_install'],
    timeout => 6000,
  }
  
  exec {'db_setup':
    # Since this resource may be run again when a database already exists,
    # we use db:create + db:migrate instead of db:setup.
    command => 'bundle exec rake db:create db:migrate',
    require => [Exec['generate_config'], Service['mysqld']],
    timeout => 6000,
  }
}

class web_host_setup {
  include passenger_vhost
}

class {'app_setup': }
class {'web_host_setup': }
