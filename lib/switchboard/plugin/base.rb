module Switchboard
  class Plugin
    class Base
      attr_reader :message

      def initialize(message, config)
        @message  = message
        @config   = config
      end

      def deliver!
        raise NotImplementedError, "you need to implement this method in your notifier"
      end
    end
  end
end
