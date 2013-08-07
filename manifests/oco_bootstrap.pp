class apt {
  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    user => 'root',
  }
  
  # Run apt-get update before we try to install any packages.
  Exec["apt-update"] -> Package <| |>
}

class git {
  package { 'git-core':
    ensure => installed,
  }
}

class clone_app {
  include apt
  
  require git
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
  }
  
  exec {'save_dot_vagrant':
    command => 'cp -a /vagrant/.vagrant /home/vagrant/dot_vagrant',
    before => Exec['git_clone'],
  }
  
  exec {'git_clone':
    command => 'rm -rf /vagrant/.vagrant && rm -rf /vagrant/* && git clone -b vagrant git://github.com/chrismear/one-click-orgs.git /vagrant',
  }
  
  exec {'restore_dot_vagrant':
    command => 'cp -a /home/vagrant/dot_vagrant /vagrant/.vagrant',
    require => Exec['git_clone'],
  }
}

include clone_app
