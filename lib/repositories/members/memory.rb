module Repositories
  module Members
    class Memory
      def initialize
        @members = {}
        @next_id = 1
      end

      def clear
        initialize
      end

      def save(member)
        member.id = @next_id
        @members[@next_id] = member
        @next_id += 1
        member
      end

      def all
        members
      end

      def first
        first_key = members.keys.sort.first
        members[first_key]
      end

      def last
        last_key = members.keys.sort.last
        members[last_key]
      end

      private
      attr_reader :members
    end
  end
end
