module Repositories
  module Members
    class Memory
      def initialize
        @members = {}
        @next_id = 1
      end

      def save(member)
        member.id = @next_id
        @members[@next_id] = member
        @next_id += 1
      end

      def last
        members[@next_id - 1]
      end

      private
      attr_reader :members
    end
  end
end
