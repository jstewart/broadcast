require 'xmpp4r-simple'

module Broadcast
  class Plugin
    class Jabber < Plugin::Base
      def initialize(message, config)
        @message        = message
        @recipients     = config[:recipients]
        @client         = ::Jabber::Simple.new(config[:user], config[:pass], nil, "Available", config[:host], config[:port] || 5222)
        sleep 4
      end

      def deliver!
        @recipients.each { |r| @client.deliver(r, @message) }
      end
    end
  end
end
