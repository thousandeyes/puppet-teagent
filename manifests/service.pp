# == Class: te_agent::service
#
# Handles the te-agent service.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::service {

  $te_agent_service_ensure = $te_agent::te_agent ? {
    true  => 'running',
    false => 'stopped',
  }

  # Addresses issue to fetch init system on RedHat < 7 versions.
  if ($facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['full'],'7') < 0 ) {
    Service {
      provider => 'upstart',
    }
  }

  service { 'te-agent':
    ensure     => $te_agent_service_ensure,
    enable     => $te_agent::te_agent,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['te-agent'],File['/etc/te-agent.cfg']],
    subscribe  => File['/etc/te-agent.cfg'],
  }

}
