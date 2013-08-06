class ruby {
  include rbenv
  
  require ruby_build
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
    cwd => '/home/vagrant',
    environment => 'HOME=/home/vagrant',
  }
  
  package {'ruby_dependencies':
    name => ['zlib1g-dev', 'libssl-dev', 'libreadline-dev', 'libyaml-dev'],
    ensure => installed,
  }
  
  exec {'build_ruby':
    command => '/usr/local/bin/ruby-build 1.9.3-p448 /home/vagrant/.rbenv/versions/1.9.3-p448',
    creates => '/home/vagrant/.rbenv/versions/1.9.3-p448/bin/ruby',
    require => [Exec['install_rbenv'], Package['ruby_dependencies']],
    notify => Exec['rbenv_rehash', 'set_default_ruby'],
  }
  
  # Latest Rubygems is necessary to fix bug parsing UTF-8 in gemspec for gherkin.
  exec {'update_rubygems':
    command => '/home/vagrant/.rbenv/versions/1.9.3-p448/bin/gem update --system',
    subscribe => Exec['build_ruby'],
    refreshonly => true
  }
}
