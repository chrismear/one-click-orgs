class bundler {
  include ruby
  include rbenv
  
  exec {'gem_install_bundler':
    command => '/home/vagrant/.rbenv/versions/1.9.3-p448/bin/gem install bundler --no-ri --no-rdoc',
    creates => '/home/vagrant/.rbenv/versions/1.9.3-p448/bin/bundle',
    require => Exec['build_ruby'],
    notify => Exec['rbenv_rehash'],
  }
}
