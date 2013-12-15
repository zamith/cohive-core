require 'active_record'

module Repositories
  module Members
    class ActiveRecord
      def clear
        Member.all.map(&:destroy)
      end

      def save(member)
        ::Member.new(Member.create(member.value).value)
      end

      def all
        Member.all.map do |member|
          ::Member.new member.value
        end
      end

      def first
        ::Member.new(Member.first.value)
      end

      def last
        ::Member.new(Member.last.value)
      end

      class Member < ::ActiveRecord::Base
        def value
          Serializers::Pipeline.new(self).serialize(attrs_method: :attributes)
        end
      end
    end
  end
end
