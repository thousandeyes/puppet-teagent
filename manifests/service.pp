# == Class: teagent::service
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::service {
  $service_require = [
    Package['te-agent'],
    File['/var/lib/te-agent/config_teagent.sh']
  ]

 case $::operatingsystem {
    centos, redhat, ubuntu: {
      $customservice = true
      if ($::osfamily == 'RedHat') and ($::operatingsystemrelease =~ /^7/) {
        # systemd
        $start = '/usr/bin/systemctl start te-agent'
        $stop = '/usr/bin/systemctl stop te-agent'
        $restart = '/usr/bin/systemctl restart te-agent' # This will work even if te-agent is stopped.
        $status = '/usr/bin/systemctl status te-agent'
      }
      elsif $::lsbdistcodename == 'xenial' {
        # systemd
        $start = '/bin/systemctl start te-agent'
        $stop = '/bin/systemctl stop te-agent'
        $restart = '/bin/systemctl restart te-agent' # This will work even if te-agent is stopped.
        $status = '/bin/systemctl status te-agent'
      }
      else {
        # Upstart
        $start = '/sbin/start te-agent'
        $stop = '/sbin/stop te-agent'
        $restart = '/sbin/stop te-agent; /sbin/start te-agent' # /bin/restart won't work if it's not running.
        $status = '/sbin/status te-agent'
      }
    }
    default: {
      $customservice = false
    }
  }

  if ($customservice == false) {
    # Use defaults if none explictly set.
    service { 'te-agent':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => $service_require,
    }
  }
  else {
    service { 'te-agent':
      ensure     => running,
      hasrestart => true,
      hasstatus  => true,
      start      => $start,
      stop       => $stop,
      restart    => $restart,
      status     => $status,
      require    => $service_require,
      subscribe  => File['/var/lib/te-agent/config_teagent.sh'],
    }
  }
}
