module Repositories
  module Spaces
    class Memory
      def initialize
        @spaces = {}
        @next_id = 1
      end

      def clear
        initialize
      end

      def all
        @spaces
      end

      private
      attr_reader :spaces
    end
  end
end
