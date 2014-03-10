# Class: nginx
#
#   Installs the `nginx` package for supported operating systems.
#
# Sample Usage:
#
#   class { 'nginx': }
#
class nginx {
  include nginx::params

  if ! $nginx::params::package {
    fail( "No nginx package defined for ${::hostname}" )
  }
}
