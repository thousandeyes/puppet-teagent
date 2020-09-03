# == Class: te_agent::install
#
# Manages packages: te-agent, te-browserbot, te-agent-utils and te-intl-fonts.
#
# === Copyright
#
# Copyright © 2020 ThousandEyes, Inc.
#
class te_agent::install {

  $te_agent_package_ensure = $te_agent::agent ? {
    true  => 'installed',
    false => 'purged',
  }

  $browserbot_package_ensure = $te_agent::browserbot ? {
    true  => 'installed',
    false => 'purged',
  }

  $xvfb_package_ensure = $te_agent::xvfb ? {
    true  => 'installed',
    false => 'purged',
  }

  $agent_utils_package_ensure = $te_agent::agent_utils ? {
    true  => 'installed',
    false => 'purged',
  }

  $international_langs_package_ensure = $te_agent::international_langs ? {
    true  => 'installed',
    false => 'purged',
  }

  package { 'te-agent':
    ensure  => $te_agent_package_ensure,
  }

  package { 'te-browserbot':
    ensure  => $browserbot_package_ensure,
    require => Package['te-agent'],
  }

  package { 'te-xvfb':
    ensure  => $xvfb_package_ensure,
    require => Package['te-agent'],
  }

  package { 'te-agent-utils':
    ensure  => $agent_utils_package_ensure,
    require => Package['te-agent'],
  }

  package { 'te-intl-fonts':
    ensure  => $international_langs_package_ensure,
  }

}
