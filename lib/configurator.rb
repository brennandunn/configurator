module Configurator
  module ClassMethods
    
    def default_configuration(hsh = {})
      hsh.symbolize_keys!
      @@default_configuration = hsh
    end
    
    def get_default_configuration
      @@default_configuration
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

      def [](key)
        pair = ConfigurationHash.find_by_key_and_owner(key.to_s, @reference)
        if pair.nil?
          @defaults[key.to_sym] || nil
        else
          pair.value
        end
      end

      def []=(key, value)
        pair = ConfigurationHash.find_by_key_and_owner(key.to_s, @reference)
        unless pair
          pair = ConfigurationHash.new(@options)
          pair.key, pair.value = key.to_s, value
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
          self[key] = value
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
