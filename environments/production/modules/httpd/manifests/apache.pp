class httpd::apache {
  case $facts['osfamily'] {
    'CentOS', 'RedHat': {
      $packagename = 'httpd'
      $vhost_path = '/etc/httpd/conf.d/vhost.conf'
      $server_ip = $facts['ipaddress_enp0s8']
      $document_root = '/var/www/html/'
      package { $packagename:
        ensure =>'installed',
      }

      # file { $document_root:
      #   ensure => directory,
      #   before => File['/var/www/html/index.html'],
      # }
      # $vhost_hash = {
      #   'server_ip'     => $server_ip,
      #   'document_root' => $document_root,
      # }
      # file { $vhost_path:
      #   content => epp('httpd/vhost.conf.epp', $vhost_hash),
      #   notify  => Service[$packagename],
      # }

      # file { '/var/www/html/index.html':
      #   ensure  => file,
      #   content => epp('apache/index.html.epp',$facts),
      #   notify  => Service[$packagename],
      #   # Loads /etc/puppetlabs/code/environments/production/modules/apache/templates/index.html.epp
      # }

      notify { 'httpd is installed.':
      }

      service { $packagename:
        ensure => 'running',
        enable => true,
      }

      notify { "$packagename is running.":
      }
    }
    'Debian', 'Ubuntu': {
      $packagename = 'apache2'
      $vhost_path = '/etc/apache2/sites-enabled/vhost.conf'
      $document_root = '/var/www/html/'
      $server_ip = $facts['ipaddress_eth1']
      package { $packagename:
        ensure => installed,
      }
      # file { $document_root:
      #   ensure => directory,
      #   before => File['/var/www/html/index.html'],
      # }
      $vhost_hash = {
        'server_ip'     => $server_ip,
        'document_root' => $document_root,
      }
      # file { $vhost_path:
      #   content => epp('apache/vhost.conf.epp', $vhost_hash),
      #   notify => Service[$packagename],
      # }
      #
      # file { '/var/www/html/index.html':
      #   ensure  => file,
      #   content => epp('httpd/index.html.epp',$facts),
      #   notify  => Service[$packagename],
      #   # Loads /etc/puppetlabs/code/environments/production/modules/apache/templates/index.html.epp
      # }
      notify { "$packagename is installed.":
      }
      service { $packagename:
        ensure => 'running',
        enable => true,
      }
      notify { "$packagename is running.":
      }
    }
    default: {
      notify { 'Oops...smth went wrong':
      }
    }
  }
}
