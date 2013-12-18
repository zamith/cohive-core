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

      def save(space)
        if space.id
          update_existing(space)
        else
          create(space)
        end
        space
      end

      def find_by_id(id)
        @spaces[id]
      end

      private
      attr_reader :spaces

      def create(space)
        space.id = @next_id
        spaces[@next_id] = space
        @next_id += 1
      end

      def update_existing(space)
        spaces[space.id] = space
      end
    end
  end
end
