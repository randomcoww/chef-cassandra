class ChefCassandra
  class Provider
    class Query < Chef::Provider
      require 'cassandra'

      provides :cassandra_query, os: "linux"

      def load_current_resource
        @current_resource = ChefCassandra::Resource::Query.new(new_resource.name)
        current_resource
      end

      def action_run
        converge_by("CQL Query: #{new_resource}") do

          cluster = Cassandra.cluster(new_resource.cluster_options)
          session = cluster.connect(new_resource.keyspace)

          if !new_resource.arguments.nil? && !new_resource.arguments.empty?
            session.execute(new_resource.query, arguments: new_resource.arguments)
          else
            session.execute(new_resource.query)
          end
        end
      end
    end
  end
end