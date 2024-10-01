# == Class: te_agent::dependency
#
# Checks for required dependencies.
#
# === Copyright
#
# Copyright © 2020 ThousandEyes, Inc.
#
class te_agent::dependency{

  $os_family   = $facts['os']['family']
  $os_distro   = $facts['os']['distro']['id']
  $os_codename = $facts['os']['distro']['codename']
  $os_release  = $facts['os']['release']['major']

  case $os_family {

    'Debian': {
      case $os_distro {
        'Ubuntu': {
          if !($os_codename in ['xenial', 'bionic', 'focal', 'jammy']) {
            fail('Only Ubuntu 16.04 (xenial), 18.04 (bionic), 20.04 (focal) and 22.04 (jammy) are supported. Please contact support.')
          }
        }
        default: {
          fail("Operating system ${os_distro} ${os_release} ${os_codename} is not supported.")
        }
      }
    }

    'RedHat': {
      case $os_distro {
        'CentOS', 'RedHat': {
          if !($os_release in ['7', '8', '9']) {
            fail('Only CentOS/RHEL 7, 8 and 9 are supported. Please contact support.')
          }
        }
        default: {
          fail("Operating system ${os_distro} ${os_release} ${os_codename} is not supported.")
        }
      }
    }

    default: {
      fail("Operating system ${os_family} family is not supported.")
    }
  }

}
