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

  # upstart provider doesn't work well on redhat/centos
  case $::operatingsystem {
    centos, redhat, ubuntu: {
      service { 'te-agent':
        ensure     => running,
        hasrestart => true,
        hasstatus  => true,
        start      => '/sbin/start te-agent',
        stop       => '/sbin/stop te-agent',
        restart    => '/sbin/stop te-agent; /sbin/start te-agent',
        status     => '/sbin/status te-agent',
        require    => $service_require,
        subscribe  => File['/var/lib/te-agent/config_teagent.sh'],
      }
    }
    default: {
      service { 'te-agent':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => $service_require,
      }
    }
  }
}
