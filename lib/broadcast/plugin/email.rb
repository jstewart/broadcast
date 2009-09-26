require 'pony'

module Broadcast
  class Plugin
    class Email < Plugin::Base

      def initialize(message, config)
        @config     = config
        @config.merge!(:body => message)
      end

      def deliver!
        Pony.mail(@config)
      end
    end
  end
end
