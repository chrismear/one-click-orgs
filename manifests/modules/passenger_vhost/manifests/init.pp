class passenger_vhost {
  include apache
  
  require passenger_config
  
  file {"${apache::params::vdir}/001-oco_dev":
    content => template('passenger_vhost/passenger_vhost.conf.erb'),
    owner => 'root',
    group => 'root',
    mode => '777',
    notify => Service['httpd'],
  }
}
