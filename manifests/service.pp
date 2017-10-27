# == Class: te_agent::service
#
# Handles the te-agent service.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::service {

  # Addresses issue to fetch init system on RedHat < 7 versions.
  if ($facts['os']['family'] == 'RedHat' and versioncmp($facts['os']['release']['full'],'7') < 0 ) {
    Service {
      provider => 'upstart',
    }
  }

  $te_agent_service_ensure = $te_agent::agent ? {
    true  => 'running',
    false => 'stopped',
  }

  $te_agent_service_enable = $te_agent::agent_service_enable ? {
    undef   => $te_agent::agent,
    default => $te_agent::agent_service_enable,
  }

  service { 'te-agent':
    ensure     => $te_agent_service_ensure,
    enable     => $te_agent_service_enable,
    hasrestart => true,
    hasstatus  => true,
    require    => [Package['te-agent'],File['/etc/te-agent.cfg']],
    subscribe  => File['/etc/te-agent.cfg'],
  }

}
