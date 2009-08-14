module Broadcast
  class Plugin
    class Base
      attr_reader :message

      def initialize(message, config)
        if (message.nil? || config.nil?)
          raise ArgumentError, "you need to supply both a message and a config hash"
        end

        @message  = message
        @config   = config
      end

      def deliver!
        raise NotImplementedError, "you need to implement this method in your notifier"
      end
    end
  end
end
