module CassandraWrapper
  CONFIG_PATH ||= '/etc/cassandra/cassandra.yaml'

  class CassandraCluster
    require 'cassandra'

    def initialize(cluster_options, timeout)
      Timeout::timeout(timeout) {
        while true
          begin
            @cluster = Cassandra.cluster(cluster_options={})
            return

          rescue Cassandra::Errors::NoHostsAvailable
            Chef::Log.info("Waiting #{timeout} seconds for hosts to come up...")

          end
          sleep 1
        end
      }
    end

    def query(keyspace, query, arguments=[], ignore_already_exists=true)
      session = @cluster.connect(keyspace)
      session.execute(query, arguments: arguments)

    rescue Cassandra::Errors::AlreadyExistsError => e
      if ignore_already_exists
        Chef::Log.warn("Resource already exists: #{e.message}")
      else
        raise e
      end
    end
  end
end
