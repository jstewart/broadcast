require File.dirname(__FILE__) + "/plugin/base"

module Broadcast
  class Plugin
    def self.available
      @@_plugins ||= {}
      @@_plugins
    end

    def self.register(klass)
      raise ArgumentError.new("Invalid plugin") unless valid_plugin?(klass)
      available[klass.to_s.split(":").last.to_plugin_name.to_sym] = klass
    end

    def self.valid_plugin?(plugin)
      plugin != Plugin::Base
    end

    def self.load(config)
      config[:plugins].each do |plugin|
        self.register(self.const_get(plugin.to_class_name))
      end
    end
  end
end
