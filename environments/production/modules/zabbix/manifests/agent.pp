class zabbix::agent {
  $server = '192.168.56.110'
  $listenPort = '10050'
  #$listenIP = '0.0.0.0'
  $startAgents = '3'
  $serverActive = 'ServerActive=192.168.56.100:10051'
  $hostname = 'Zabbix server'
  $zabbix_package_agent = 'zabbix-agent'
  $agent_configfile_path = '/etc/zabbix/zabbix_agentd.conf'

  # Installing the package
  package { $zabbix_package_agent:
    ensure  => installed,
    require => Class['zabbix::repo'],
    tag     => 'zabbix',
  }
  case $is_server {
    true: {
      $listenIP  = '127.0.0.1'
    }
    default:             {
      $listenIP  = '192.168.56.110'
    }
  }
  service { 'zabbix-agent':
    ensure     => running,
    enable     => true,
    provider   => $service_provider,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$zabbix_package_agent],
  }
  $agent_hash = {
    'document_root' => $document_root,
    'server'        => $server,
    'listenPort'    => $listenPort,
    'listenIP'      => $listenIP,
    'startAgents'   => $startAgents,
    'serverActive'  => $serverActive,
    'hostname'      => $hostname,
    'zabbix_package_agent' => $zabbix_package_agent,
  }

  file { $agent_configfile_path:
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0644',
    notify  => Service['zabbix-agent'],
    require => Package[$zabbix_package_agent],
    replace => true,
    content => epp('zabbix/zabbix_agentd.conf.epp', $agent_hash),
  }
}