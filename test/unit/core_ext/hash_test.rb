require File.dirname(__FILE__) + "/../../helpers"

class HashTest < Test::Unit::TestCase
  context "#symbolize_keys" do
    setup do
      @h = {"key" => {"nested_hash_key" => "value"}}
    end

    should "convert the key to a symbol" do
      assert_equal :key, @h.symbolize_keys.keys.first
    end

    should "work on nested hashes" do
      assert_equal :nested_hash_key, @h.symbolize_keys[:key].keys.first
    end
  end
end
