require File.dirname(__FILE__) + "/../../../helpers"

class Broadcast::Plugin::BaseTest < Test::Unit::TestCase
  context "initiliazing new" do
    should "initialize the new plugin" do
      assert_nothing_raised do
        Broadcast::Plugin::Base.new("TEST", {})
      end
    end

    should "raise an exception without a message to assign" do
      assert_raise(ArgumentError) do
        Broadcast::Plugin::Base.new(nil, {})
      end
    end

    should "raise an exception without a config to assign" do
      assert_raise(ArgumentError) do
        Broadcast::Plugin::Base.new("TEST", nil)
      end
    end
  end

  context "calling #deliver!" do
    should "not allow this method to be called on this base class" do
      assert_raise(NotImplementedError) do
        Broadcast::Plugin::Base.new("TEST", {}).deliver!
      end
    end
  end
end
