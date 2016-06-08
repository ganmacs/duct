# frozen_string_literal: true

module Dukt
  module Input
    class Base
      def configure
      end

      def start
        raise NotImplementedError
      end
    end
  end
end
