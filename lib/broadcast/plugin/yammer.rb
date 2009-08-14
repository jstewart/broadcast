require 'yammer4r'

module Broadcast
  class Plugin
    class Yammer < Plugin::Base
      def initialize(message, config = {})
        @message        = message
        @yammer_client  = ::Yammer::Client.new(:config => config.delete(:oauth_yml)) 
      end
      
      def deliver!
        @yammer_client.message(:post, :body => @message)
      end
    end
  end
end

