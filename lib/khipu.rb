require "openssl"
require 'net/http'
require 'json'

require "khipu/version"
require "khipu/config"
require "khipu/payment"
require "khipu/confirmation"

module Khipu
  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end
end
