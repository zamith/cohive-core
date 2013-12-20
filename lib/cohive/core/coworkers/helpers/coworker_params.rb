module Coworkers
  class CoworkerParams
    attr_reader :member, :company
    def initialize(member: {}, company: {})
      @member = member
      @company = company
    end

    def full
      if member && !member.empty?
        member_is_available
      else
        company
      end
    end

    private
    def member_is_available
      if company && !company.empty?
        member.merge({company_attributes: company})
      else
        member
      end
    end
  end
end
