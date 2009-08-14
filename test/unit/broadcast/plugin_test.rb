require File.dirname(__FILE__) + "/../../helpers"

class Broadcast::Plugin::TestPlugin < Broadcast::Plugin::Base; end

class Broadcast::PluginTest < Test::Unit::TestCase
  context "when listing available plugins" do
    should "initialize an empty hash when no plugins are registered" do
      assert_equal({}, Broadcast::Plugin.available)
    end

    should "return the plugin registry" do
      Broadcast::Plugin.available[:test] = Broadcast::Plugin::TestPlugin
      assert_equal({:test => Broadcast::Plugin::TestPlugin}, Broadcast::Plugin.available)
    end
  end

  context "when validating plugins" do
    should "be invalid when plugin is a Plugin::Base class" do
      assert_equal false, Broadcast::Plugin.valid_plugin?(Broadcast::Plugin::Base)
    end

    should "be valid when plugin is not a Plugin::Base class" do
      assert_equal true, Broadcast::Plugin.valid_plugin?(Broadcast::Plugin::TestPlugin)
    end
  end

  context "when registering plugins" do
    should "raise an argument error when the plugin is not valid" do
      assert_raise(ArgumentError) do
        Broadcast::Plugin.register(Broadcast::Plugin::Base)
      end
    end

    should "add the plugin to the list of available plugins" do
      available_plugins = stub
      Broadcast::Plugin.expects(:available).returns(available_plugins)
      available_plugins.expects(:[]=).with(:test_plugin, Broadcast::Plugin::TestPlugin)
      Broadcast::Plugin.register(Broadcast::Plugin::TestPlugin)
    end
  end

  context "when loading plugins" do
    should "register the plugin" do
      config = {:plugins => ["test_plugin"]}
      Broadcast::Plugin.expects(:register).with(Broadcast::Plugin::TestPlugin)
      Broadcast::Plugin.load(config)
    end
  end
end
