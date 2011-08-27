class passenger {
  include passenger::params
  require ruby
  require gcc
  require apache::dev
  $version=$passenger::params::version
  
  Exec {
    path => [ '/home/vagrant/.rbenv/versions/1.9.2-p290/bin', $passenger::params::gem_binary_path, '/usr/bin', '/bin'],
    logoutput => true,
  }
  
  package {'passenger-compilation-dependencies':
    name => 'libcurl4-openssl-dev',
  }
  
  exec {'install_passenger_gem':
    creates => "/home/vagrant/.rbenv/versions/1.9.2-p290/lib/ruby/gems/1.9.1/gems/passenger-$version/bin/passenger-install-apache2-module",
    command => "gem install -v $version passenger",
  }

  exec {'compile-passenger':
    command => 'passenger-install-apache2-module -a',
    creates => $passenger::params::mod_passenger_location,
    require => [Exec['install_passenger_gem'], Package['passenger-compilation-dependencies']],
  }
}
