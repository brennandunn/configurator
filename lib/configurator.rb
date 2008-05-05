module Configurator
  module ClassMethods
    
    def default_configuration(hsh = {})
      hsh.symbolize_keys!
      @@default_configuration = hsh
    end
    
    def get_default_configuration
      @@default_configuration rescue {}
    end
  
  end
  
  module InstanceMethods
    
    def config
      @config_proxy ||= ConfigProxy.new(self)
    end

    def config=(hsh)
      config.from_hash(hsh)
      config
    end

    class ConfigProxy

      attr_reader :defaults

      def initialize(reference)
        @reference = reference
        @options = { :associated_id => reference.id, :associated_type => reference.class.name }
        @defaults = reference.class.get_default_configuration || {}
      end

      def [](*keys)
        namespace, key = [keys].flatten
        if key.nil?
          key = namespace
          namespace = nil
        end

        pair = ConfigurationHash.find_by_key_and_owner(key.to_s, @reference, namespace ? namespace.to_s : nil)
        if pair.nil?
          namespace ? @defaults[namespace][key] : @defaults[key] rescue nil
          #@defaults[namespace ? keys : key.to_sym] || nil
        else
          pair.value
        end
        
      end

      def []=(*keys)
        if keys.size == 3
          namespace, key = keys[0], keys[1]
          value = keys[2]
        else
          key, value = keys[0], keys[1]
        end
                
        pair = ConfigurationHash.find_by_key_and_owner(key.to_s, @reference, namespace ? namespace.to_s : nil)
        unless pair
          pair = ConfigurationHash.new(@options)
          pair.key, pair.value = key.to_s, value
          pair.namespace = namespace.to_s if namespace
          pair.save
        else
          pair.value = value
          pair.save
        end
        value
      end

      def to_hash(with_defaults = false)
        Hash[ *ConfigurationHash.find_all_by_owner(@reference).map { |pair| [pair.key, pair.value] }.flatten ]
      end

      def from_hash(hsh)
        hsh.each do |key, value|
          if value.is_a?(Hash)
            namespace = key
            value.each do |key, value|
              self[namespace, key] = value
            end
          else
            self[key] = value
          end
        end
      end

      def method_missing(method, *args, &block)
        self[method.to_s]
      end

    end
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
  
end
