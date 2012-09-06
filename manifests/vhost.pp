define nginx::vhost (
  $ensure             = 'present',
  $default_vhost      = false,
  $virtual_ip         = '*',
  $virtual_port       = '80',
  $location           = '/',
  $server_name,
  $www_root           = undef,
  $index_files        = ['index.html', 'index.php', 'index.htm'],
  $allow_from         = undef,
  $deny_from          = undef,
  $access_log         = undef,
  $proxy_pass         = undef,
  $proxy_http_header  = undef,
  $proxy_https_header = undef,
  $ssl_enabled        = false,
  $ssl_cert           = undef,
  $ssl_key            = undef,
  $ssl_client         = false,
  $ssl_client_cert    = undef,
  $ssl_verify_client  = undef,
  $ssl_session        = '5m',
  $ssl_depth          = '1',
  $ssl_protocols      = 'SSLv3 TLSv1',
  $ssl_ciphers        = 'ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv3:+EXP'
) {

  File {
    owner => 'root',
    group => 'root',
    mode  => 0644,
  }
  
  if ($ssl_enabled == true) {
    if ($ssl_cert == undef) or ($ssl_key == undef) {
      fail('nginx: SSL certificate/key (ssl_cert/ssl_cert) and/or SSL Private must be defined and exist on the target system(s)')
    }
  }

  if ($ssl_client == true) {
    if ($ssl_client_cert == undef) {
      fail('nginx: CA certificate (ssl_client_cert) must exist on target system')
    }

    if ($ssl_verify_client == undef) {
      fail('nginx: Must specify a value for client side certificate verification (ssl_verify_client)')
    }
  }
  
  file { "/etc/nginx/conf.d/${name}.conf":
    ensure  => $ensure,
    content => template("nginx/vhost.conf.erb"),
    notify  => Class['nginx::service'],
  }
}
