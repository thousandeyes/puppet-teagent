# == Class: teagent::repo
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::repo(
  $ensure = 'present',
  ) {

  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  $ensure_real = $ensure ? {
      'absent' => absent,
      default => 'present',
  }

  case $::operatingsystem {
    Ubuntu,Debian: {
      file {
        '/etc/apt/trusted.gpg.d/thousandeyes-apt-key.pub':
          ensure => $ensure_real,
          source => 'puppet:///modules/teagent/thousandeyes-apt-key.pub',
      }

      apt::source {
        'thousandeyes':
          location   => 'http://apt.thousandeyes.com',
          repos      => 'main',
          key        => 'C99A15F5BE718900',
          key_source => '/etc/apt/trusted.gpg.d/thousandeyes-apt-key.pub',
          require    => File['/etc/apt/trusted.gpg.d/thousandeyes-apt-key.pub'],
      }
    }
    CentOS,redhat: {
      $repo_os = $::operatingsystem ? {
        /(?i-mx:centos)/ => 'CentOS',
        /(?i-mx:redhat)/ => 'RHEL',
        default          => 'UNSET',
 
      file {
        '/etc/yum.repos.d/RPM-GPG-KEY-thousandeyes':
          ensure => $ensure_real,
          source => 'puppet:///modules/teagent/RPM-GPG-KEY-thousandeyes',
          notify  => Exec['update-yum']
      }

      file {
        '/etc/yum.repos.d/thousandeyes.repo':
          ensure  => $ensure_real,
          content => template('teagent/thousandeyes.repo.erb'),
          require => File['/etc/apt/trusted.gpg.d/thousandeyes-apt-key.pub'],
          notify  => Exec['update-yum']
      }

      exec {
        '/usr/bin/yum clean all':
          path        => [ '/bin/',
                           '/sbin/',
                           '/usr/bin/',
                           '/usr/sbin/' ],
          alias       => 'update-yum',
          logoutput   => 'on_failure',
          subscribe   => [ File['/etc/yum.repos.d/RPM-GPG-KEY-thousandeyes'],
                           File['/etc/yum.repos.d/thousandeyes.repo'],
          refreshonly => true
      }
    }
    default: { notify { 'not-available': message => 'This OS is not supported.' }
  }
}
