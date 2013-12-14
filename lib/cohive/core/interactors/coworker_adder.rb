class CoworkerAdder
  def initialize(params: nil, space: nil)
    @member_repo = Repository.for(:member)
    @company_repo = Repository.for(:company)
    @params = params
    @space = space
    @member = Member.new member_params
  end

  def add
    member.company_id = company.id
    member.space_id = space.id
    member_repo.save member
  end

  def valid?
    return true if member.valid?

    if member.errors.size == 1 && member.errors[:company].present?
      params.company[:name].present?
    end
  end

  private
  attr_reader :member, :params, :space, :member_repo, :company_repo

  def company
    first_or_initialize(company_search).tap do |company_representation|
      company_representation.space_id = space.id
      company_repo.save company_representation
    end
  end

  def member_params
    if company_search && company_search != ""
      params.member
    else
      params.member.merge({boss: true})
    end
  end

  def company_search
    @_company_search ||= company_repo.where(name: params.company[:name], space_id: space.id)
  end

  def first_or_initialize(company_search)
    return company_search.first if company_search.first

    Company.new(name: params.company[:name])
  end
end