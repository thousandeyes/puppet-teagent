# == Class: te_agent
#
# Puppet module for the ThousandEyes agent.
#
# === Parameters
#
# [*account_token*]
#   Account token for the agent.
#   Default: 'account_token' (Sample value)
#
# [*agent*]
#  Handles the ThousandEyes agent package.
#  Possible values: true ('installed'), false ('purged').
#  Default: true.
#
# [*agent_service_enable*]
#  Enables or not the te-agent service.
#  Possible values: true, false,undef (If left undefined it will equal the agent parameter value).
#  Default: undef.
#
# [*agent_utils*]
#  Handles instalation of the agent utils package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false.
#
# [*browserbot*]
#  Handles the browserbot package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false.
#
# [*crash_reports*]
#   Agent crash reports.
#   Possible values: 0 (disabled), 1 (enabled).
#   Default: 1
#
# [*international_langs*]
#  Handles the international language package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false.
#
# [*log_file_size*]
#   Agent log file size in MB.
#   Default: 10
#
# [*log_level*]
#   Agent log level.
#   Possible values are: 'DEBUG', 'TRACE'
#   Default: 'DEBUG'
#
# [*log_path*]
#   Agent log path.
#   Default: '/var/log'
#
# [*num_log_files*]
#   Amount of agent's log files.
#   Default: 13
#
# [*proxy_auth_type*]
#   Proxy authentication type.
#   Possible values: 'BASIC','KERBEROS','NTLM'.
#   Default: (disabled)
#
# [*proxy_bypass_list*]
#   Proxy bypass list. Comma separated value.
#   Default: (disabled)
#
# [*proxy_location*]
#   Proxy location.
#   Default: (disabled)
#
# [*proxy_pass*]
#   Proxy password.
#   Default: (disabled)
#
# [*cluster_master_host*]
#   Hostname of the clustermaster.
#   Default: undef.
#
# [*proxy_type*]
#   Proxy type.
#   Possible values: 'DIRECT','STATIC','PAC'.
#   Default: 'DIRECT' (No proxy enabled).
#
# [*proxy_user*]
#   Proxy username.
#   Default: (disabled)
#
# [*set_repository*]
#  Handles or not the ThousandEyes repository installation.
#  Possible values: true, false.
#  Default: true.
#
# === Examples
#
# Call te_agent as a parameterized class
#
# See README for details.
#
# === Authors
#
# Gaston Bezzi <gaston@thousandeyes.com>
# Paulo Cabido <paulo@thousandeyes.com>
# Diogo Iglesias <diglesias@thousandeyes.com>
#
# === Copyright
#
# Copyright © 2020 ThousandEyes, Inc.
#

class te_agent(
  String $account_token                                      = 'account_token',
  Boolean $agent                                             = true,
  Optional[Boolean] $agent_service_enable                    = undef,
  Boolean $agent_utils                                       = false,
  Boolean $browserbot                                        = false,
  Boolean $xvfb                                              = false,
  Integer[0,1] $crash_reports                                = 1,
  Boolean $international_langs                               = false,
  Integer[0] $log_file_size                                  = 10,
  Enum['DEBUG','TRACE'] $log_level                           = 'DEBUG',
  String $log_path                                           = '/var/log',
  Integer[0] $num_log_files                                  = 13,
  Optional[Enum['BASIC','KERBEROS','NTLM']] $proxy_auth_type = undef,
  Optional[String] $proxy_bypass_list                        = undef,
  Optional[String] $proxy_location                           = undef,
  Optional[String] $proxy_pass                               = undef,
  Optional[String] $cluster_master_host                      = undef,
  Enum['DIRECT','STATIC','PAC'] $proxy_type                  = 'DIRECT',
  Optional[String] $proxy_user                               = undef,
  Boolean $set_repository                                    = true,
){

  class { 'te_agent::dependency': }
  -> class { 'te_agent::repository':}
  -> class { 'te_agent::install': }
  -> class { 'te_agent::config': }
  ~> class { 'te_agent::service': }

  contain te_agent::dependency
  contain te_agent::repository
  contain te_agent::install
  contain te_agent::config
  contain te_agent::service
}
