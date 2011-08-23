class mysql {
  package { "mysql-server": ensure => installed }
  package { "mysql-client": ensure => installed }

  service { "mysqld":
    ensure => running,
    require => Package["mysql-server"],
  }
}
