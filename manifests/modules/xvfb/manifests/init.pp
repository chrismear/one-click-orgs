class xvfb {
  Exec {
    path => ['/usr/local/bin', '/usr/bin', '/bin'],
    cwd => '/home/vagrant',
    logoutput => true,
    timeout => 6000,
    user => 'vagrant',
    environment => 'HOME=/home/vagrant',
  }

  package { 'xvfb':
    ensure => installed,
  }

  exec { 'export_display':
    require => Package['xvfb'],
    command => 'echo \'export DISPLAY=:99.0\' >> .bash_profile',
    unless => 'cat .bash_profile | grep \'DISPLAY=:99.0\'',
  }

  service{ 'xvfbd':
    require => Package['xvfb'],
    provider => base,
    name => 'Xvfb',
    start => '/sbin/start-stop-daemon --start --quiet --pidfile /tmp/xvfb.pid --make-pidfile --background --exec /usr/bin/Xvfb -- :99 -ac -screen 0 1024x768x24',
    stop => '/sbin/start-stop-daemon --stop --quiet --pidfile /tmp/xvfb.pid; rm -f /tmp/xvfb.pid',
    status => '/sbin/start-stop-daemon --status --quiet --pidfile /tmp/xvfb.pid',
    ensure => running,
    subscribe => Package['xvfb'],
  }
}
