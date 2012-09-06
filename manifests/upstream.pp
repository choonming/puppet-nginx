define nginx::upstream(
  $ensure = 'present',
  $members
) {

  File { 
    owner => 'root', 
    group => 'root', 
    mode  => '0644', 
  }
  
  file { '/etc/nginx/conf.d/proxy-upstream.conf':
    content => template('nginx/proxy-upstream.conf.erb'),
    notify  => Class['nginx::service'],
  }

}
