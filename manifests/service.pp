# == Class teagent::service
#
# This class is meant to be called from teagent
# It ensure the service is running
#
class teagent::service {

  service { 'te-agent':
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
