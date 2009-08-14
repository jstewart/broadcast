require File.dirname(__FILE__) + "/../../helpers"

class StringTest < Test::Unit::TestCase
  context "#to_class_name" do
    setup do
      @s = "my_class"
    end

    should "convert an underscored string to a camel case class name" do
      assert_equal "MyClass", @s.to_class_name
    end
  end
end
