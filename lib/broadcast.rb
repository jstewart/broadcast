require 'rubygems'
require 'timeout'
require 'broadcast/core_ext/string'
require 'broadcast/core_ext/hash'
require 'broadcast/plugin'
require 'broadcast/plugin/email'

module Broadcast
  VERSION = '0.0.1'

  def self.new(message, config={})
    self.message  = message
    self.config   = config
    Plugin.load(self.config)
  end

  def self.default_config
    @default ||= {
      :plugins          => ['email'],
      :plugin_options   => {},
      :timeout          => 8
    }
  end

  def self.config
    @config ||= default_config.dup
  end

  def self.config=(options)
    @config = default_config.merge(options)
  end

  def self.message=(msg)
    @message = msg
  end

  def self.message 
    @message
  end

  def self.deliver!
    raise ArgumentError.new("No message to send") unless self.message

    timeout_sec = self.config[:timeout] || 8

    Plugin.available.each do |plugin_name, plugin_class|
      begin
        Timeout.timeout(timeout_sec) { 
          plugin_class.new(self.message, config[:plugin_options][plugin_name]).deliver! 
        }
      rescue Timeout::Error
        STDERR.puts "DELIVERY FAILURE: #{plugin_name} exceeded maximum timeout of #{timeout_sec} seconds"
      end
    end
  end
end
