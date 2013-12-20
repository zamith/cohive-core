module Coworkers
  class CoworkerAdder
    def initialize(params: nil, space: nil)
      @member_repo = Repository.for(:member)
      @company_repo = Repository.for(:company)
      @params = params
      @space = space
      @member = Member.new member_params
    end

    def add
      if member.valid?
        member.company_id = company.id
        member.space_id = space.id
        member_repo.save(member).value
      end
    end

    def valid?
      return true if member.valid?

      if member.errors.size == 1 && member.errors[:company].present?
        params.company[:name].present?
      end
    end

    def errors
      member.errors
    end

    private
    attr_reader :member, :params, :space, :member_repo, :company_repo

    def company
      company_representation = first_or_initialize(company_search)
      company_representation.space_id = space.id
      company_repo.save(company_representation)
    end

    def member_params
      if existent_company?
        regular_member
      else
        promote_to_boss
      end
    end

    def regular_member
      params.member
    end

    def promote_to_boss
      params.member.merge({boss: true})
    end

    def existent_company?
      company_search && !company_search.empty?
    end

    def company_search
      @_company_search ||= company_repo.where(name: params.company[:name], space_id: space.id)
    end

    def first_or_initialize(company_search)
      return company_search.first if company_search.first

      Coworkers::Company.new(name: params.company[:name])
    end
  end
end
