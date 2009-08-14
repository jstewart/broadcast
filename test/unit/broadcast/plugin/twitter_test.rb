require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::TwitterTest < Test::Unit::TestCase
  def setup 
    @twitter_client   = stub_everything
    @config           = {
      :email => 'jstew1974@example.com',
      :password => 'xxx',
      :direct_message => true,
      :dm_to => ['jstew1974'], 
    }
    Twitter::Base.stubs(:new).with('jstew1974@example.com', 'xxx').returns(@twitter_client)
  end

  context "initiliazing new instance" do
    should "create a new twitter client with the correct options" do
      Twitter::Base.expects(:new).with('jstew1974@example.com', 'xxx')
      Broadcast::Plugin::Twitter.new("TEST", @config)
    end
  end

  context "delivering the message" do
    should "post a direct message when the :direct_message config option is set" do
      @config[:direct_message] = true
      @twitter_client.expects(:direct_message_create).with('jstew1974', "TEST")
      Broadcast::Plugin::Twitter.new("TEST", @config).deliver!
    end

    should "post a tweet when the :direct_message config option is not set" do
      @config[:direct_message] = false
      @twitter_client.expects(:post).with("TEST")
      Broadcast::Plugin::Twitter.new("TEST", @config).deliver!
    end

  end
end
