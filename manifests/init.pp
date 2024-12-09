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
#  Default: true
#
# [*agent_service_enable*]
#  Enables or not the te-agent service.
#  Possible values: true, false,undef (If left undefined it will equal the agent parameter value).
#  Default: undef
#
# [*agent_utils*]
#  Handles instalation of the agent utils package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false
#
# [*browserbot*]
#  Handles the browserbot package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false
#
# [*crash_reports*]
#   Agent crash reports.
#   Possible values: 0 (disabled), 1 (enabled).
#   Default: 1
#
# [*international_langs*]
#  Handles the international language package.
#  Possible values: true ('installed'), false ('purged').
#  Default: false
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
#   Default: undef
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
#   Handles or not the ThousandEyes repository installation.
#   Possible values: true, false.
#   Default: true
#
# [*bbot_params*]
#   BBot Orchestrator parameters.
#   Type: Hash with the following keys:
#     - server: BBot Orchestrator server parameters.
#       Type: Hash with the following keys:
#         - port: BBot Orchestrator server port.
#           Type: Integer
#           Default: undef
#     - log: BBot Orchestrator log parameters.
#       Type: Hash with the following keys:
#         - logFilePath: BBot Orchestrator all level log file path.
#           Type: String
#           Default: undef
#         - warnLogFilePath: BBot Orchestrator above warning log file path.
#           Type: String
#           Default: undef
#         - containerLogFilePath: BBot Orchestrator container log file path.
#           Type: String
#           Default: undef
#         - level: BBot Orchestrator standard logger level.
#           Type: String
#           Default: undef
#         - maxSizeMB: BBot Orchestrator log file max size in MB.
#           Type: Integer
#           Default: undef
#         - maxAgeDays: BBot Orchestrator log file max age in days.
#           Type: Integer
#           Default: undef
#         - maxBackups: BBot Orchestrator max number of log file backups.
#           Type: Integer
#           Default: undef
#         - enableChromeDriverVerboseLogging: BBot Orchestrator enable ChromeDriver verbose logging.
#           Type: Boolean
#           Default: undef
#         - collectNetLogData: BBot Orchestrator collect network log data.
#           Type: Boolean
#           Default: undef
#         - enableTLSKeysLogging: BBot Orchestrator enable TLS keys logging.
#           Type: Boolean
#           Default: undef
#         - tlsKeysLogFilePath: BBot Orchestrator TLS keys log file path.
#           Type: String
#           Default: undef
#     - test: BBot Orchestrator test parameters.
#       Type: Hash with the following keys:
#         - screenshotDir: BBot Orchestrator screenshot directory.
#           Type: String
#           Default: undef
#         - harDir: BBot Orchestrator Har directory.
#           Type: String
#           Default: undef
#         - kerberosRootDir: BBot Orchestrator Kerberos root directory.
#           Type: String
#           Default: undef
#         - hostChromeHomeDirectory: BBot Orchestrator Chrome home directory.
#           Type: String
#           Default: undef
#         - testTimeoutOverheadSec: BBot Orchestrator test timeout (setup + test execution) overhead in seconds.
#           Type: Integer
#           Default: undef
#         - testResultTimeoutSec: BBot Orchestrator time allowed to collect test results and logsin seconds.
#           Type: Integer
#           Default: undef
#         - testEndTimeoutSec: BBot Orchestrator time allowed to end test before collecting results in seconds.
#           Type: Integer
#           Default: undef
#         - testTearDownTimeoutSec: BBot Orchestrator time allowed to tear down the environment after results and
#                                   logs have been collected in seconds.
#           Type: Integer
#           Default: undef
#         - deserializeTimeoutSec: BBot Orchestrator time allowed to deserialize an agent request in seconds.
#           Type: Integer
#           Default: undef
#         - serializeTimeoutSec: BBot Orchestrator time allowed to serialize an agent response in seconds.
#           Type: Integer
#           Default: undef
#     - podman: BBot Orchestrator podman parameters.
#       Type: Hash with the following keys:
#         - imageName: BBot Orchestrator podman image name.
#           Type: String
#           Default: undef
#         - rootfs: BBot Orchestrator podman rootfs.
#           Type: String
#           Default: undef
#         - socketPath: BBot Orchestrator podman domain socket path.
#           Type: String
#           Default: undef
#         - sharedDir: BBot Orchestrator path to the shared directory that will be mounted into the podman container.
#           Type: String
#           Default: undef
#         - ipv4NetworkName: BBot Orchestrator name of the ipv4 only cni network.
#           Type: String
#           Default: undef
#         - dualStackNetworkName: BBot Orchestrator name of the dual stack cni network.
#           Type: String
#           Default: undef
#         - ipv4PodName: BBot Orchestrator name of the ipv4 only pod.
#           Type: String
#           Default: undef
#         - dualStackPodName: BBot Orchestrator name of the dual stack pod.
#           Type: String
#           Default: undef
#         - installationRetryMax: BBot Orchestrator maximum number of retries for podman image installation.
#           Type: Integer
#           Default: undef
#         - installationRetryWaitMinMs: BBot Orchestrator minimum wait time in milliseconds between retries for
#                                       podman image installation.
#           Type: Integer
#           Default: undef
#         - installationRetryWaitMaxMs: BBot Orchestrator maximum wait time in milliseconds between retries for
#                                       podman image installation.
#           Type: Integer
#           Default: undef
#         - infraPodImageName: BBot Orchestrator podman infra pod image name.
#           Type: String
#           Default: undef
#         - infraPodImagePath: BBot Orchestrator podman infra pod image path.
#           Type: String
#           Default: undef
#         - containerResourceLimitsChrome: BBot Orchestrator resource limits for the Chrome container.
#           Type: Hash with the following keys:
#             - memoryLimitBytes: Memory limit in bytes.
#               Type: Integer
#               Default: undef
#             - cpuQuota: CPU hardcap limit (in microsecond). Allowed cpu time in a given period.
#               Type: Integer
#               Default: undef
#             - cpuPeriod: CPU period to be used for hardcapping (in microsecond).
#               Type: Integer
#               Default: undef
#     - installation: BBot Orchestrator installation parameters.
#       Type: Hash with the following keys:
#         - timeoutSec: BBot Orchestrator installation/upgrade timeout in seconds.
#           Type: Integer
#           Default: undef
#     - sqlite: BBot Orchestrator SQLite parameters.
#       Type: Hash with the following keys:
#         - dbFilePath: BBot Orchestrator SQLite database file path.
#           Type: String
#           Default: undef
#   Default: undef
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
  #
  # Browserbot parameters
  #
  Optional[Struct[{
    Optional[server] =>
      Optional[Struct[{
        Optional[port] => Optional[Integer],
      }]],
    Optional[log] =>
      Optional[Struct[{ 
        Optional[logFilePath]                      => Optional[String],
        Optional[warnLogFilePath]                  => Optional[String],
        Optional[containerLogFilePath]             => Optional[String],
        Optional[level]                            => Optional[String],
        Optional[maxSizeMB]                        => Optional[Integer],
        Optional[maxAgeDays]                       => Optional[Integer],
        Optional[maxBackups]                       => Optional[Integer],
        Optional[enableChromeDriverVerboseLogging] => Optional[Boolean],
        Optional[collectNetLogData]                => Optional[Boolean],
        Optional[enableTLSKeysLogging]             => Optional[Boolean],
        Optional[tlsKeysLogFilePath]               => Optional[String],
      }]],
    Optional[test] =>
      Optional[Struct[{
        Optional[screenshotDir]           => Optional[String],
        Optional[harDir]                  => Optional[String],
        Optional[kerberosRootDir]         => Optional[String],
        Optional[hostChromeHomeDirectory] => Optional[String],
        Optional[testTimeoutOverheadSec]  => Optional[Integer],
        Optional[testResultTimeoutSec]    => Optional[Integer],
        Optional[testEndTimeoutSec]       => Optional[Integer],
        Optional[testTearDownTimeoutSec]  => Optional[Integer],
        Optional[deserializeTimeoutSec]   => Optional[Integer],
        Optional[serializeTimeoutSec]     => Optional[Integer],
      }]],
    Optional[podman] =>
      Optional[Struct[{
        Optional[imageName]                     => Optional[String],
        Optional[rootfs]                        => Optional[String],
        Optional[socketPath]                    => Optional[String],
        Optional[sharedDir]                     => Optional[String],
        Optional[ipv4NetworkName]               => Optional[String],
        Optional[dualStackNetworkName]          => Optional[String],
        Optional[ipv4PodName]                   => Optional[String],
        Optional[dualStackPodName]              => Optional[String],
        Optional[installationRetryMax]          => Optional[Integer],
        Optional[installationRetryWaitMinMs]    => Optional[Integer],
        Optional[installationRetryWaitMaxMs]    => Optional[Integer],
        Optional[infraPodImageName]             => Optional[String],
        Optional[infraPodImagePath]             => Optional[String],
        Optional[containerResourceLimitsChrome] => 
          Optional[Struct[{
            Optional[memoryLimitBytes] => Optional[Integer],
            Optional[cpuQuota]         => Optional[Integer],
            Optional[cpuPeriod]        => Optional[Integer],
          }]],
      }]],
    Optional[installation] =>
      Optional[Struct[{
        Optional[timeoutSec] => Optional[Integer],
      }]],
    Optional[sqlite] =>
      Optional[Struct[{
        Optional[dbFilePath] => Optional[String],
      }]],
  }]] $bbot_params = undef,
){

  class { 'te_agent::dependency': }
  -> class { 'te_agent::repository':}
  -> class { 'te_agent::install': }
  -> class { 'te_agent::config': bbot_params => $bbot_params }
  -> class { 'te_agent::service': }

  contain te_agent::dependency
  contain te_agent::repository
  contain te_agent::install
  contain te_agent::config
  contain te_agent::service
}
