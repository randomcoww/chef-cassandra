class ChefCassandra
  class Resource
    class Query < Chef::Resource
      resource_name :cassandra_query

      default_action :run
      allowed_actions :run

      #http://docs.datastax.com/en/developer/ruby-driver/3.0/api/cassandra/#cluster-class_method

      property :keyspace, String
      property :query, String
      property :cluster_options, Hash, default: {}
      property :arguments, Array, default: []
      property :timeout, Integer, default: 10

    end
  end
end
