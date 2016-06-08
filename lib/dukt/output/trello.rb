# frozen_string_literal: true
require 'dukt/output/base'
require 'dukt/client/pocket'

module Dukt
  module Input
    class Trello < Base
      def emit(v)
        id = client.find_or_create_list
        v.values.each do |e|
          require 'pp'
          pp e
          # client.create_card(name: e[0], desc: e[1], list_id: id)
        end
      end

      def client
        @client ||= TrelloClient.new
      end
    end
  end
end
