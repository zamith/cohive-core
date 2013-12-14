require 'spec_helper'
require 'entities/company'

describe "Companies Repository" do
  let(:repo) { Repository.for(:company) }

  context "#where" do
    it "finds a company by name" do
      company_name = "new company"
      company = Company.new name: company_name
      repo.save company

      expect(repo.where(name: company_name).first).to eq company
    end

    it "finds a company by name and space id" do
      company_name = "new company"
      space_id = 1
      company = Company.new name: company_name, space_id: space_id
      repo.save company

      expect(repo.where(name: company_name, space_id: space_id).first).to eq company
    end
  end
end
