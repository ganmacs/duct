# frozen_string_literal: true
require 'dukt/client/base_http'

module Dukt
  module Client
    class Pocket < BaseHttps
      def retrieve(opt = {})
        response = connection.post(URI.escape('/v3/get'), params.merge(opt))
        raise "Invalid response status: #{response.status}" if response.status != 200
        response.body
      end

      %w(add archive readd favorite unfavorite delete
         tags_add tags_remove tags_replace tags_clear tag_rename).each do |e|
        define_method(e) do |opt|
          modify(e, opt)
        end
      end

      private

      def modify(action, opt = [])
        actions = Array(opt).map { |e| e.merge(action: action) }
        connection.post('/v3/send', params.merge(actions: actions))
        raise "Invalid response status: #{response.status}" if response.status != 200
      end

      def default_host
        'getpocket.com'
      end

      def params
        @params ||= {
          consumer_key: Dukt.env('pocket_consumer_key') || ENV['POCKET_CONSUMER_KEY'],
          access_token: Dukt.env('pocket_access_token') || ENV['POCKET_ACCESS_TOKEN']
        }
      end
    end
  end
end
