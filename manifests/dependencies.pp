# = Class to manage dependencies
class teagent::dependencies {
  case $::operatingsystem {
    Ubuntu,Debian: { require teagent::dependencies::ubuntu }
    CentOS,redhat: { require teagent::dependencies::centos }
    default:       { notify('We do not support this OS') }
  }
}
