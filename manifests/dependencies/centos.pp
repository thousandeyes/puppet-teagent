# = private class
# = Class to manage centos packages
class teagent::dependencies::centos {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::operatingsystemrelease < 6.3 {
    if ! defined(Package['te-agent']) {
      package {
        'te-agent':
          ensure   => $teagent::version,
          provider => 'yum',
      }
    }

    if $browserbot == true {
      if ! defined(Package['te-browserbot']) {
        package {
          'te-browserbot':
            ensure   => $teagent::version,
            provider => 'yum',
            require  => Package['te-agent'],
        }
      }
    }

    if $agent_utils == true {
      if ! defined(Package['te-agent-utils']) {
        package {
          'te-agent-utils':
            ensure   => $teagent::version,
            provider => 'yum',
            require  =>  Package['te-agent'],
        }
      }
    }

    if $international_langs == true {
      if ! defined(Package['te-intl-fonts']) {
        package {
          'te-intl-fonts':
            ensure   => $teagent::version,
            provider => 'yum',
            require  => Package['te-agent']
        }
      }
    }
  }
  default: {
    fail("Please upgrade your operating system to ${::operatingsystem} to >= 6.3")
  }
}
