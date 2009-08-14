require 'twitter'

module Broadcast
  class Plugin
    class Twitter < Plugin::Base
      def initialize(message, config)
        @config         = config
        @message        = message
        @twitter_client = ::Twitter::Base.new(@config[:email], @config[:password]) 
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
