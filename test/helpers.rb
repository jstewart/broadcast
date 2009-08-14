$:.unshift File.dirname(__FILE__) + "/../lib", File.dirname(__FILE__)

require "rubygems"
require "test/unit"
require "shoulda"
require "mocha"

require "broadcast"
require "broadcast/core_ext/hash"
require "broadcast/core_ext/string"
require "broadcast/plugin"
require "broadcast/plugin/email"
require "broadcast/plugin/yammer"
