module Repositories
  module Companies
    class Memory
      def initialize
        @companies = {}
        @next_id = 1
      end

      def clear
        initialize
      end

      def save(company)
        if company.id
          update_existing(company)
        else
          create(company)
        end
        company
      end

      def all
        companies
      end

      def where(conditions = {})
        companies.values.select do |company|
          matches_conditions?(company, conditions)
        end
      end

      def find_by_id(id)
        companies[id]
      end

      private
      attr_reader :companies

      def matches_conditions?(company, conditions)
        conditions.map do |name, expected_value|
          company.public_send(name) == expected_value
        end.all?
      end

      def create(company)
        company.id = @next_id
        companies[@next_id] = company
        @next_id += 1
      end

      def update_existing(company)
        companies[company.id] = company
      end
    end
  end
end
