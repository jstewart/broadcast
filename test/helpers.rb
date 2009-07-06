$:.unshift File.dirname(__FILE__) + "/../lib", File.dirname(__FILE__)

require "rubygems"
require "test/unit"
require "shoulda"
require "mocha"

require "broadcast"
require "broadcast/plugin"
require "broadcast/plugin/email"
