class rbenv {
  require git
  
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    cwd => '/home/vagrant',
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
    environment => 'HOME=/home/vagrant',
  }
  
  exec {'install_rbenv':
    creates => '/home/vagrant/.rbenv',
    command => 'git clone git://github.com/sstephenson/rbenv.git .rbenv',
  }
  
  # Add rbenvs' bin and shim directories to $PATH, unless they're already there.
  exec {'amend_path':
    require => Exec['install_rbenv'],
    command => 'echo \'export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"\' >> .bash_profile',
    unless => 'cat .bash_profile | grep \'.rbenv/bin\'',
  }
  
  exec {'rbenv_rehash':
    command => '/home/vagrant/.rbenv/bin/rbenv rehash',
    refreshonly => true,
  }
  
  exec {'set_default_ruby':
    command => '/home/vagrant/.rbenv/bin/rbenv global 1.9.3-p448',
    require => Exec['rbenv_rehash'],
    refreshonly => true,
  }
}
