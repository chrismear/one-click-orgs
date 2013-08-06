class mysql {
  package { "mysql-server": ensure => installed }
  package { "mysql-client": ensure => installed }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
}
