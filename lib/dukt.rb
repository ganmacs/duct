$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dukt/engine'

module Dukt
  class << self
    attr_reader :opt

    def configure(opt = {})
      @opt = opt
    end

    def env(key)
      opt[key] if opt.has_key?(key)
      nil
    end

    def opt
      @opt ||= {}
    end
  end
end

Dukt.configure
Dukt::Engine.load_all
Dukt::Engine.define('pocket', 'trello')


# dukt in: 'pocket', out: 'trello'
