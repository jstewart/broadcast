require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::YammerTest < Test::Unit::TestCase
  def setup 
    @yammer_client  = stub_everything
    @config         = {:oauth_yml => "/etc/broadcast/yammer_oauth.yml"}
    Yammer::Client.stubs(:new).with(:config => "/etc/broadcast/yammer_oauth.yml").returns(@yammer_client)
  end

  context "initiliazing new instance" do
    should "create a new yammer client with the correct oauth file" do
      Yammer::Client.expects(:new).with(:config => "/etc/broadcast/yammer_oauth.yml")
      Broadcast::Plugin::Yammer.new("TEST", @config)
    end
  end

  context "delivering the message" do
    should "send the message with the created yammer client" do
      @yammer_client.expects(:message).with(:post, :body => "TEST")
      Broadcast::Plugin::Yammer.new("TEST", @config).deliver!
    end
  end
end
