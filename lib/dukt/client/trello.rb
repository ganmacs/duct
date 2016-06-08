# frozen_string_literal: true
require 'dukt/client/base_http'

module Dukt
  module Client
    class Trello < BaseHttps
      DEFAULT_BOARD = 'inbox'
      DEFAULT_LIST = 'dukt list'

      def initialize(opt = {})
        @board_name = opt.fetch('board', DEFAULT_BOARD)
        @list_name = opt.fetch('list', DEFAULT_LIST)
      end

      def create_cards(v)
        v.each(&:create_cards)
      end

      def create_card(list_id: nil, due: 'null', name:, desc:)
        lid = list_id || find_or_create_list
        response = connection.post('/1/cards', params.merge(name: name, desc: desc, idList: lid, due: due))
        raise "Invalid response status: #{response.status}" if response.status != 200
        response.body
      end

      def find_or_create_list
        ls = list.select { |e| e['name'] == @list_name }
        if ls.empty?
          response = connection.post('/1/list', params.merge(name: @list_name, idBoard: board['id']))
          response.body['id']
        else
          ls.first['id']
        end
      end

      def list
        @list ||= board['lists']
      end

      def board
        @board ||= begin
          b = boards.select { |e| e['name'] == @board_name }
          raise "Unknow Board name #{@board_name}" if b.empty? # fix
          b.first
        end
      end

      def boards
        response = connection.get('/1/members/me/boards', params.merge(filter: 'open', lists: 'open'))
        raise "Invalid response status: #{response.status}" if response.status != 200
        response.body
      end

      private

      def default_host
        'trello.com'
      end

      def params
        @params ||= {
          key: Dukt.env('trello_application_key') || ENV['TRELLO_APPLICATION_KEY'],
          token: Dukt.env('trello_api_token') || ENV['TRELLO_API_TOKEN']
        }
      end
    end
  end
end
