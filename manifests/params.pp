# Class: nginx::params
#
#   Data class containing operating-system-specific variables for use by other
#   module classes.
#
# Sample Usage:
#
# class nginx::random_class {
#   $myvar = $nginx::params::myvar
#
#   file { $myvar: }
# }
#
class nginx::params {
  case $::operatingsystem {
    'ubuntu': {
      include ssl::params
      $server_names_hash_bucket_size = 32
      $default_ssl_path   = $ssl::params::ssl_path
      $default_ssl_cert   = $ssl::params::ssl_cert_file
      $default_ssl_key    = $ssl::params::ssl_key_file
      $default_log_format = hiera('nginx::params::default_log_format', 'combined')
      $default_webroot    = '/var/www'
      $etcdir             = '/etc/nginx'
      $fastcgi_params     = '/etc/nginx/fastcgi_params'
      $hasrestart         = true
      $hasstatus          = true
      $package            = 'nginx-extras'
      $phpfpm_service     = 'php5-fpm'
      $restart            = '/usr/sbin/nginx -t && /etc/init.d/nginx reload'
      $service            = 'nginx'
      $threadcount        = $::processorcount
      $user               = 'www-data'
      $confd              = "${etcdir}/conf.d"
      $vdir               = "${etcdir}/sites-enabled"
    }
    default: {
      fail("Sorry, nginx module doesn't support ${::operatingsystem} yet.")
    }
  }
}

