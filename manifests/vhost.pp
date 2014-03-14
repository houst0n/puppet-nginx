# Define: nginx::server::vhost
#
#   Deploy an nginx vhost configuration file.
#
# Parameters:
#
# Requires:
#   include nginx::server
#
define nginx::vhost(
  $port             = '80',
  $priority         = '10',
  $template         = 'nginx/vhost-default.conf.erb',
  $servername       = '',
  $ssl              = false,
  $ssl_port         = '443',
  $ssl_path         = $nginx::server::default_ssl_path,
  $ssl_cert         = $nginx::server::default_ssl_cert,
  $ssl_key          = $nginx::server::default_ssl_key,
  $magic            = '',
  $serveraliases    = undef,
  $template_options = {},
  $isdefaultvhost   = false,
  $vhostroot        = '',
  $autoindex        = false,
  $webroot          = $nginx::server::default_webroot,
  $lua_shared_dict  = $nginx::server::lua_shared_dict,
) {

  include nginx
  include nginx::server
  include nginx::params

  # Determine the name of the vhost
  if $servername == '' {
    $srvname = $name
  } else {
    $srvname = $servername
  }

  # Determine the location to put the root of this vhost
  if $vhostroot == '' {
    $docroot = "${webroot}/${srvname}"
  } else {
    $docroot = $vhostroot
  }

  exec { 'create docroot':
    command => "mkdir -p ${docroot} && chown ${nginx::params::user} ${docroot}",
    unless  => "test -d ${docroot}",
    require => Class['nginx::server'],
  }

  file { $docroot:
    ensure  => present,
    owner   => $nginx::params::user,
    group   => $nginx::params::user,
    mode    => '0755',
    require => Exec['create docroot'],
  }

  # Write the nginx configuration
  file { "${nginx::params::vdir}/${priority}-${name}":
    content => template($template),
    owner   => 'root',
    group   => '0',
    mode    => '0755',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

}
