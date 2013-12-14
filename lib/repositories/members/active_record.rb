require 'active_record'

module Repositories
  module Members
    class ActiveRecord
      def save(member)
        ::Member.new(Member.create(member.value).value)
      end

      class Member < ::ActiveRecord::Base
        def value
          Serializers::Pipeline.new(self).serialize(attrs_method: :attributes)
        end
      end
    end
  end
end
