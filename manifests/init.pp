# == Class: te_agent
#
# Puppet module for the ThousandEyes agent.
#
# === Parameters
#
# [*proxy_user*]
#   Proxy username.
#   Default: (disabled)
#
# [*proxy_pass*]
#   Proxy password.
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
# [*proxy_auth_type*]
#   Proxy authentication type.
#   Possible values: 'BASIC','KERBEROS','NTLM'.
#   Default: (disabled)
#
# [*proxy_type*]
#   Proxy type.
#   Possible values: 'DIRECT','STATIC','PAC'.
#   Default: 'DIRECT' (No proxy enabled).
#
# [*log_level*]
#   Agent log level.
#   Possible values are: 'DEBUG', 'TRACE'
#   Default: 'DEBUG'
#
# [*log_file_size*]
#   Agent log file size in MB.
#   Default: 10
#
# [*num_log_files*]
#   Amount of agent's log files.
#   Default: 13
#
# [*crash_reports*]
#   Agent crash reports.
#   Possible values: 0 (disabled), 1 (enabled).
#   Default: 1
#
# [*log_path*]
#   Agent log path.
#   Default: '/var/log'
#
# [*account_token*]
#   Account token for the agent.
#   Default: 'account_token' (Sample value)
#
# [*te_agent*]
#  Handles the ThosuandEyes agent package.
#  Possible values: true ('installed'), false ('purged').
#  Default: true.
#
# [*international_langs*]
#  Handles the international language package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false.
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
#
# === Copyright
#
# Copyright © 2017 ThousandEyes, Inc.
#

class te_agent(
Optional[String] $proxy_user = undef,
Optional[String] $proxy_pass = undef,
Optional[String] $proxy_bypass_list = undef,
Optional[String] $proxy_location = undef,
Optional[Enum['BASIC','KERBEROS','NTLM']] $proxy_auth_type = undef,
Enum['DIRECT','STATIC','PAC'] $proxy_type = 'DIRECT',
Enum['DEBUG','TRACE'] $log_level = 'DEBUG',
Integer[0] $log_file_size = 10,
Integer[0] $num_log_files = 13,
Integer[0,1] $crash_reports = 1,
String $log_path = '/var/log',
String $account_token = 'account_token',
Boolean $te_agent = true,
Boolean $international_langs = false,
Boolean $agent_utils = false,
Boolean $browserbot = false,
Boolean $set_repository = true,
){

  class { 'te_agent::dependency': }
  -> class { 'te_agent::repository':}
  -> class { 'te_agent::install': }
  -> class { 'te_agent::config': }
  ~> class { 'te_agent::service': }

}
