Facter.add(:is_server) do
  confine :kernel => 'Linux'
  setcode do
    if File.exist? '/etc/zabbix/zabbix_server.conf'
      true
    else
      false
    end
  end
end
