class ruby_build {
  require git
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
  }
  
  package {'curl':
    ensure => installed
  }
  
  exec {'clone_ruby_build':
    cwd => '/home/vagrant',
    creates => '/home/vagrant/ruby-build',
    command => 'git clone git://github.com/sstephenson/ruby-build.git'
  }
  
  exec {'install_ruby_build':
    require => Exec['clone_ruby_build'],
    cwd => '/home/vagrant/ruby-build',
    creates => '/usr/local/bin/ruby-build',
    command => '/home/vagrant/ruby-build/install.sh',
    user => 'root',
  }
}
