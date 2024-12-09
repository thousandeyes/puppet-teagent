# == Class: te_agent::config
#
# Handles te te-agent configuration.
#
# === Parameters
#
# [*bbot_params*]
#   Hash of parameters for the te-browserbot.yaml file.
#
# === Copyright
#
# Copyright © 2020 ThousandEyes, Inc.
#
class te_agent::config (
  Hash $bbot_params = {},
) {

  $te_agent_file_ensure = $te_agent::agent ? {
    true  => present,
    false => absent,
  }

  $browserbot_file_ensure = $te_agent::browserbot ? {
    true  => present,
    false => absent,
  }

  file { '/etc/te-agent.cfg':
    ensure  => $te_agent_file_ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('te_agent/te-agent.cfg.erb'),
  }

  file { '/usr/local/te-browserbot/support/te-browserbot.yaml':
    ensure => $browserbot_file_ensure,
    owner  => 'browserbot',
    group  => 'browserbot',
    mode   => '0644',
    content => template('te_agent/te-browserbot.yaml.erb'),
  }
}
