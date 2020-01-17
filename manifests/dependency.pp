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
  $os_release  = $facts['os']['release']['full']

  case $os_family {

    'RedHat': {
      if (versioncmp($os_release,'6.3') <= 0 ) {
        fail("Please upgrade your operating system ${os_family} ${os_release} to version 6.3 or newer.")
      }
    }

    'Debian': {
      if !($os_release in ['14.04','16.04','18.04']) {
        fail('Only Ubuntu 14.04 (trusty), 16.04 (xenial) and 18.04 (bionic) are supported. Please contact support.')
      }
    }

    default: {
      fail("Operating system ${os_family} ${os_release} is not supported.")
    }
  }

}
