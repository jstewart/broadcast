# Shamelssly stolen from Sinatra::Mailer 
# which was shamlessly stolen from Merb::Mailer

require 'net/smtp'
require 'mailfactory'
require 'tlsmail'

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

module Switchboard
  class Plugin
    class Email < Plugin::Base

      def initialize(message, config)
        @mail           = MailFactory.new()
        @mail.to        = config.delete(:recipients)
        @mail.from      = config.delete(:from)
        @mail.subject   = config.delete(:subject)
        @mail.text      = message
        @config         = config
      end

      def deliver!
        Net::SMTP.start(@config[:host], @config[:port].to_i, @config[:domain], 
                        @config[:user], @config[:pass], @config[:auth]) { |smtp|
          smtp.send_message(@mail.to_s, @mail.from.first, @mail.to.to_s.split(/[,;]/))
        }
      end
    end
  end
end
