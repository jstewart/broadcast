require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::JabberTest < Test::Unit::TestCase
  def setup 
    @jabber_client  = stub_everything
    @config         = {
      :user => "jstewart", 
      :pass => "ponies",
      :host => "localhost", 
      :port => 5222, 
      :recipients => ["jstewart@fusionary.com"]
    }
    Jabber::Simple.stubs(:new).with("jstewart", "ponies", nil, "Available", "localhost", 5222).returns(@jabber_client)
  end

  context "initiliazing new instance" do
    should "create a new jabber client with the correct oauth file" do
      Jabber::Simple.expects(:new).with("jstewart", "ponies", nil, "Available", "localhost", 5222)
      Broadcast::Plugin::Jabber.new("TEST", @config)
    end
  end

  context "delivering the message" do
    should "send the message with the created jabber client" do
      @jabber_client.expects(:deliver).with("jstewart@fusionary.com", "TEST")
      Broadcast::Plugin::Jabber.new("TEST", @config).deliver!
    end
  end
end
