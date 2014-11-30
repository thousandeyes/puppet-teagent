# = private class
# = Class to manage ubuntu and debian packages
class teagent::dependencies::ubuntu {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::lsbmajdistrelease {
    '6','12','13','14': {
      if ! defined(Package['te-agent']) {
        package {
          'te-agent':
            ensure   => $teagent::version,
            provider => 'aptitude',
            require  => Class['teagent::repo']
        }
      }

      if $browserbot == true {
        if ! defined(Package['te-browserbot']) {
          package {
            'te-browserbot':
              ensure   => $teagent::version,
              provider => 'aptitude',
              require  => [
                           Class['teagent::repo'],
                           Package['te-agent'],
              ],
          }
        }
      }

      if $agent_utils == true {
        if ! defined(Package['te-agent-utils']) {
          package {
            'te-agent-utils':
              ensure   => $teagent::version,
              provider => 'aptitude',
              require  => [
                           Class['teagent::repo'],
                           Package['te-agent'],
              ],
          }
        }
      }

      if $international_langs == true {
        if ! defined(Package['te-intl-fonts']) {
          package {
            'te-intl-fonts':
              ensure   => $teagent::version,
              provider => 'aptitude',
              require  => [
                           Class['teagent::repo'],
                           Package['te-agent'],
              ],
          }
        }
      }
    }
    default: { fail('Only Debian 6 (squeeze - 6.x) is supported. Please contact support.') }
}
