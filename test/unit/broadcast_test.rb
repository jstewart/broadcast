require File.dirname(__FILE__) + "/../helpers"

class BroadcastTest < Test::Unit::TestCase
  context "#new" do
    should "require a message" do
      assert_raise ArgumentError do 
        Broadcast.new
      end
    end

    should "allow only a message and no config" do
      assert_nothing_raised {Broadcast.new("TEST")}
    end

    should "assign message" do
      Broadcast.expects(:message=).with("TEST")
      Broadcast.new("TEST")
    end

    should "assign config" do
      Broadcast.expects(:config=).with({:plugins => ["dummy"]})
      Broadcast.new("TEST", :plugins => ["dummy"])
    end

    should "load the plugins" do
      Broadcast.stubs(:config).returns({})
      Broadcast::Plugin.expects(:load).with({})
      Broadcast.new("TEST")
    end
  end

  context "#default_config" do
    should "assign @default" do
      Broadcast.default_config
      assert_equal({:plugins => ['email'], :plugin_options => {}, :timeout => 8}, 
                   Broadcast.instance_variable_get('@default'))
    end
  end

  context "#config" do
    should "assign to @config" do
      default_config = mock("default_config")
      Broadcast.stubs(:default_config).returns(default_config)
      default_config.expects(:dup).returns({})
      Broadcast.config
      assert_equal({}, Broadcast.instance_variable_get("@config"))
    end
  end

  context "#config=" do
    should "merge passed in config hash with default" do
      myconfig = {:plugins => ['test']}
      Broadcast.stubs(:default_config).returns({})
      Broadcast.config = myconfig
      assert_equal myconfig, Broadcast.instance_variable_get("@config")
    end
  end

  context "#message=" do
    should "assign @message" do
      Broadcast.message = "TEST"
      assert_equal "TEST", Broadcast.instance_variable_get("@message")
    end
  end

  context "#message" do 
    should "return @message" do
      Broadcast.instance_variable_set("@message", "TEST MESSAGE")
      assert_equal "TEST MESSAGE", Broadcast.message
    end
  end

  context "#deliver!" do
    setup do
      email_options = {
        :from => "test@example.com",
        :recipients => "test@example.com", :subject => "TEST"
      } 
      @email_plugin_mock = mock("email_plugin")
      @email_plugin_mock.stubs(:deliver!)
      @email_plugin.stubs(:new).returns(@email_plugin_mock)
      Broadcast::Plugin.stubs(:available).returns({:email => @email_plugin})
      Broadcast.stubs(:message).returns("TEST MSG")
      Broadcast.stubs(:config).returns({:plugin_options => {}})
    end

    should "Raise an error if there's no message to send" do
      Broadcast.stubs(:message).returns(nil)
      assert_raise ArgumentError do
        Broadcast.deliver!
      end
    end

    should "instantiate new plugins from avaliable plugins" do
      @email_plugin.expects(:new).returns(@email_plugin_mock)
      Broadcast.deliver!
    end

    should "deliver the message with the instantiated plugin" do
      @email_plugin_mock.expects(:deliver!)
      Broadcast.deliver!
    end

    should_eventually "Timeout if maximum time for execution expires"

  end
end
