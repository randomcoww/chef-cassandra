module Cassandra
  CONFIG_PATH ||= '/etc/cassandra/cassandra.yaml'

  def generate_config(config_hash)
    out = []

    config_hash.each do |k, v|
      parse_config_object(out, k, v, '')
    end
    return out.join($/)
  end

  def parse_config_object(out, k, v, prefix)
    case v
    when Hash
      out << [prefix, k, ':'].join
      v.each do |e, f|
        parse_config_object(out, e, f, prefix + '  ')
      end

    when Array
      v.each do |e|
        parse_config_object(out, k, e, prefix)
      end

    when String,Integer
      out << [prefix, k, ': ', v].join

    when NilClass
      out << [prefix, k, ': ', 'null'].join

    when TrueClass
      out << [prefix, k, ': ', 'true'].join

    when FalseClass
      out << [prefix, k, ': ', 'false'].join
    end
  end
end
