require File.dirname(__FILE__) + "/../../helpers"

class HashTest < Test::Unit::TestCase
  context "#keys_to_sym" do
    setup do
      @h = {"key" => {"nested_hash_key" => "value"}}
    end

    should "convert the key to a symbol" do
      assert_equal :key, @h.keys_to_sym.keys.first
    end

    should "work on nested hashes" do
      assert_equal :nested_hash_key, @h.keys_to_sym[:key].keys.first
    end
  end
end
