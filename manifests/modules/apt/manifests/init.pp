class apt {
  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    user => 'root',
  }
  
  # Run apt-get update before we try to install any packages.
  Exec["apt-update"] -> Package <| |>
}
