require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::EmailTest < Test::Unit::TestCase
  def setup 
    @config      = {
      :host => "localhost",
      :port => 25,
      :user => "jason", 
      :pass => "monkey",
      :auth => "plain",
      :domain => "localdomain",
      :recipients => "fred@example.com, jstewart@example.com",
      :from => "noreply@example.com",
      :subject => "Help! The world is being invaded by sock monekys!"
    }
  end

  context "initiliazing new instance" do
    setup do
      @mailfactory = stub_everything
      MailFactory.stubs(:new).returns(@mailfactory)
    end

    should "use MailFactory to generate the email" do
      MailFactory.expects(:new).returns(@mailfactory)
      Broadcast::Plugin::Email.new("TEST", @config)
    end

    should "set the correct options on the MailFactory" do
      @mailfactory.expects(:to=).with(@config[:recipients])
      @mailfactory.expects(:from=).with(@config[:from])
      @mailfactory.expects(:subject=).with(@config[:subject])
      @mailfactory.expects(:text=).with("TEST")
      Broadcast::Plugin::Email.new("TEST", @config)
    end
  end

  context "delivering the message" do
    should "send the message via SMTP" do
      smtp_stub   = stub
      mailfactory = stub_everything(:to_s => "TEST", 
                                    :from => stub(:first => "noreply@example.com"), 
                                    :to => stub(:to_s => "jason@example.com"))
      MailFactory.stubs(:new).returns(mailfactory)
      Net::SMTP.expects(:start).with(@config[:host], 
                                     @config[:port].to_i, 
                                     @config[:domain], 
                                     @config[:user], 
                                     @config[:pass], 
                                     @config[:auth]).yields(smtp_stub)
       smtp_stub.expects(:send_message).with("TEST", "noreply@example.com", ["jason@example.com"])

       Broadcast::Plugin::Email.new("TEST", @config).deliver!
    end
  end
end
