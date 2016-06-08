# frozen_string_literal: true
require 'dukt/input/base'
require 'dukt/client/pocket'

module Dukt
  module Input
    class Pocket < Base
      def start
        PocketFormater.new(github_items).call
      end

      private

      def github_items
        @github_items ||= client.retrieve(domain: 'github.com')
      end

      def client
        @client ||= ::Dukt::Client::Pocket.new
      end
    end

    class PocketFormater
      def initialize(body)
        @body = body
      end

      def call
        list.reduce({}) do |acc, (k, v)|
          acc.merge(k => [v['resolved_title'], v['resolved_url']])
        end
      end

      private

      def list
        @list ||= @body["list"]
      end
    end

  end
end
