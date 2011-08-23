class passenger_config {
  include apache
  include passenger
  
  $version = $passenger::params::version
  $mod_passenger_location = $passenger::params::mod_passenger_location
  
  file {"/etc/apache2/mods-enabled/passenger.load" :
    content => template('passenger_config/passenger.load.erb'),
    owner => 'root',
    group => 'root',
    mode => '777',
    require => [Package['httpd'], Exec['compile-passenger']],
    notify => Service['httpd'],
  }
  
  file {"/etc/apache2/mods-enabled/passenger.conf" :
    content => template('passenger_config/passenger.conf.erb'),
    owner => 'root',
    group => 'root',
    mode => '777',
    require => [Package['httpd'], Exec['compile-passenger']],
    notify => Service['httpd'],
  }
}
