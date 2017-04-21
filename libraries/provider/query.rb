class ChefCassandra
  class Provider
    class Query < Chef::Provider
      # require 'cassandra'
      include CassandraWrapper

      provides :cassandra_query, os: "linux"

      def load_current_resource
        @current_resource = ChefCassandra::Resource::Query.new(new_resource.name)
        current_resource
      end

      def action_run
        converge_by("CQL Query: #{new_resource}") do

          cluster = CassandraCluster.new(new_resource.cluster_options,
            new_resource.timeout)

          cluster.query(new_resource.keyspace,
            new_resource.query,
            new_resource.arguments,
            new_resource.ignore_already_exists)
        end
      end
    end
  end
end
