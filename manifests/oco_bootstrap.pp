class git {
  package { 'git-core':
    ensure => installed,
  }
}

class clone_app {
  require git
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
  }
  
  exec {'save_dot_vagrant':
    command => 'cp /vagrant/.vagrant /home/vagrant/dot_vagrant',
    before => Exec['git_clone'],
  }
  
  exec {'git_clone':
    command => 'rm -f /vagrant/.vagrant && rm -rf /vagrant/* && git clone -b vagrant git://github.com/chrismear/one-click-orgs.git /vagrant',
  }
  
  exec {'restore_dot_vagrant':
    command => 'cp /home/vagrant/dot_vagrant /vagrant/.vagrant',
    require => Exec['git_clone'],
  }
}

include clone_app
