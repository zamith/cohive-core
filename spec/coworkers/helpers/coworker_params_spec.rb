require 'coworkers/helpers/coworker_params'

module Coworkers
  describe CoworkerParams do
    context "#full" do
      context "there are member parameters" do
        it "merges the member with the company" do
          params = CoworkerParams.new member: member_params, company: company_params

          params.full.should have_key :company_attributes
          params.full.should have_key :email
        end
      end

      context "there are no member parameters" do
        it "returns the company parameters"do
          params = CoworkerParams.new company: company_params

          params.full.should eq company_params
        end
      end

      context "there are no company parameters" do
        it "returns the member parameters"do
          params = CoworkerParams.new member: member_params

          params.full.should eq member_params
        end
      end
    end

    def member_params
      @_member_params ||= { name: "John", phone_no: "1234", email: "random@example.com" }
    end

    def company_params
      @_company_params ||= { name: "GB" }
    end
  end
end
