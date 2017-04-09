class ChefCassandra
  class Resource
    class Config < Chef::Resource
      resource_name :cassandra_config

      default_action :create
      allowed_actions :create, :delete

      property :exists, [TrueClass, FalseClass]
      property :config, Hash
      property :content, String, default: lazy { config.to_yaml }
      property :path, String, desired_state: false,
                              default: lazy { Cassandra::CONFIG_PATH }

    end
  end
end
