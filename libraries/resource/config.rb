class ChefCassandra
  class Resource
    class Config < Chef::Resource
      include Cassandra

      resource_name :cassandra_config

      default_action :create
      allowed_actions :create, :delete

      property :exists, [TrueClass, FalseClass]
      property :config, Hash
      property :content, String, default: lazy { to_conf }
      property :path, String, desired_state: false,
                              default: lazy { Cassandra::CONFIG_PATH }

      private

      def to_conf
        generate_config(config)
      end
    end
  end
end
