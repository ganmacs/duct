# frozen_string_literal: true
require 'faraday'
require 'faraday_middleware'

module Dukt
  module Client
    class BaseHttp
      private

      def connection
        @connection ||= Faraday.new(url: url_prefix) do |faraday|
          faraday.request :json
          faraday.response :json
          faraday.adapter Faraday.default_adapter
        end
      end

      def default_host
        raise NotImplementedError
      end

      def url_prefix
        'http://' + default_host
      end

      def params
        raise NotImplementedError
      end
    end

    class BaseHttps < BaseHttp
      private

      def url_prefix
        'https://' + default_host
      end
    end
  end
end
