require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::EmailTest < Test::Unit::TestCase
  def setup 
    @config      = {
      :smtp => {
        :host => "localhost",
        :port => 25,
        :user => "jason", 
        :pass => "monkey",
        :auth => "plain",
        :domain => "localhost.localdomain"
      },
      :to => "fred@example.com, jstewart@example.com",
      :from => "noreply@example.com",
      :subject => "Help! The world is being invaded by sock monekys!",
      :sendmail => true
    }
  end

  context "initiliazing new instance" do
    should "create the correct instance variables" do
      email = Broadcast::Plugin::Email.new("TEST", @config)
      assert email.instance_variable_get("@config")
    end
  end

  context "delivering the message" do
    should "call pony with the corect options" do
      Pony.expects(:mail).with(@config.merge(:body => "TEST"))
      Broadcast::Plugin::Email.new("TEST", @config).deliver!
    end
  end
end
