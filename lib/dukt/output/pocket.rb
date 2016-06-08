# frozen_string_literal: true
require 'dukt/output/base'
require 'dukt/client/pocket'

module Dukt
  module Input
    class Pocket < Base
      def initialize(tag = nil)
        @tags = tag || 'github_repository'
      end

      def emit(v)
        opt = v.keys.map do |id|
          { item_id: id, tags: @tag }
        end
        client.tags_add(opt)
      end

      private

      def client
        @client ||= ::Dukt::Client::Pocket.new
      end
    end
  end
end
