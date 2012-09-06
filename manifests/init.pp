class nginx {
  
  include nginx::service
  
  package { 'nginx':
    ensure  => present,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    mode    => 0644,
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///nginx/nginx.conf',
    notify  => Class['nginx::service'],
  }

}
