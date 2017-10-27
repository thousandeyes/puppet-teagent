# == Class: te_agent::config
#
# Handles te te-agent configuration.
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#
class te_agent::config {

  $te_agent_file_ensure = $te_agent::agent ? {
    true  => present,
    false => absent,
  }

  file { '/etc/te-agent.cfg':
    ensure  => $te_agent_file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('te_agent/te-agent.cfg.erb'),
  }
}
