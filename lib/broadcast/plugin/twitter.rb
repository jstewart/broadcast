require 'twitter'

module Broadcast
  class Plugin
    class Twitter < Plugin::Base
      def initialize(message, config)
        @config         = config
        @message        = message
        auth            = ::Twitter::HTTPAuth.new(@config[:username], @config[:password])
        @twitter_client = ::Twitter::Base.new(auth) 
      end

      def deliver!
        if @config[:direct_message]
          @config[:dm_to].each { |user| @twitter_client.direct_message_create(user, @message) }
        else
          @twitter_client.post(@message)
        end
      end
    end
  end
end
