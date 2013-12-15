require 'active_record'

module Repositories
  module Members
    class ActiveRecord
      def clear
        Company.all.map(&:destroy)
      end

      def save(company)
        ::Company.new(new_or_updated_company(company).value)
      end

      def all
        Company.all.map do |company|
          ::Company.new company.value
        end
      end

      def where(conditions = {})
        Company.where(conditions).map do |company|
          ::Company.new company.value
        end
      end

      def find_by_id(id)
        company = Company.find(id)
        ::Company.new company.value
      end

      private

      def new_or_updated_company(company)
        (company.id) ? update_existing(company) : create(company)
      end

      def create(company)
        Company.create company.value
      end

      def update_existing(company)
        if existing_company = Company.find(company.id)
          existing_company.update_attributes company.value
        end
      end

      class Company < ::ActiveRecord::Base
        def value
          Serializers::Pipeline.new(self).serialize(attrs_method: :attributes)
        end
      end
    end
  end
end
