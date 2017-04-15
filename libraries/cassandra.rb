module Cassandra
  CONFIG_PATH ||= '/etc/cassandra/cassandra.yaml'

  def cqlsh(*args)
    command = ['cqlsh', args].compact.join(' ')
    Chef::Log.info("running #{comamnd}")
    shell_out!(command)
  end
end
