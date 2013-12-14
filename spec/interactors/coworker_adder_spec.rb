require 'spec_helper'
require 'interactors/coworker_adder'
require 'entities/member'
require 'entities/company'

class Space < Struct.new(:id); end
class CoworkerParams < Struct.new(:member, :company); end

describe CoworkerAdder do
  let(:member_repo) { Repository.for(:member) }
  let(:company_repo) { Repository.for(:company) }

  context "#add" do
    it "associates the coworkers with the space" do
      space = Space.new 1
      member_params = { name: "John", phone_no: "1234" }
      company_params = { name: "GB" }
      params = CoworkerParams.new(member_params, company_params)
      adder = CoworkerAdder.new params: params, space: space

      adder.add

      member = member_repo.last
      expect(member.space_id).to eq space.id
      expect(company_repo.find_by_id(member.company_id).space_id).to eq space.id
    end
#
#     context "the company does not exist" do
#       it "creates a member" do
#         space = create(:space)
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company))
#         adder = Cohive::CoworkerAdder.new params: params, space: space
#
#         expect {
#           adder.add
#         }.to change{Coworker::Member.count}.by(1)
#       end
#
#       it "creates the company" do
#         space = create(:space)
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company))
#         adder = Cohive::CoworkerAdder.new params: params, space: space
#
#         expect {
#           adder.add
#         }.to change{Coworker::Company.count}.by(1)
#       end
#
#       it "associates the company with the member" do
#         space = create(:space)
#         company_params = attributes_for(:company)
#         params = CoworkerParams.new(member: attributes_for(:member), company: company_params)
#         adder = Cohive::CoworkerAdder.new params: params, space: space
#
#         adder.add
#
#         Coworker::Member.last.company.name.should eq company_params[:name]
#       end
#
#       it "sets the member as the boss" do
#         space = create(:space)
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company))
#         adder = Cohive::CoworkerAdder.new params: params, space: space
#
#         adder.add
#
#         Coworker::Member.first.should be_boss
#       end
#     end
#
#     context "the company exists" do
#       it "does not create the company" do
#         company = create(:company, space: create(:space))
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company, name: company.name))
#         adder = Cohive::CoworkerAdder.new params: params, space: company.space
#
#         expect {
#           adder.add
#         }.not_to change{Coworker::Company.count}
#       end
#
#       it "creates a member" do
#         company = create(:company, space: create(:space))
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company, name: company.name))
#         adder = Cohive::CoworkerAdder.new params: params, space: company.space
#
#         expect {
#           adder.add
#         }.to change{Coworker::Member.count}.by(1)
#       end
#
#       it "associates the company with the member" do
#         company = create(:company, space: create(:space))
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company, name: company.name))
#         adder = Cohive::CoworkerAdder.new params: params, space: company.space
#
#         adder.add
#
#         Coworker::Member.last.company.name.should eq company.name
#       end
#
#       it "does not set a new boss" do
#         company = create(:company, space: create(:space))
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company, name: company.name))
#         adder = Cohive::CoworkerAdder.new params: params, space: company.space
#
#         adder.add
#
#         Coworker::Member.last.should_not be_boss
#       end
#
#     end
#
#     context "the company exists in another space" do
#       it "creates a new company" do
#         my_space = create(:space)
#         other_space = create(:space)
#         company = create(:company, name: "One", space: other_space)
#         params = CoworkerParams.new(member: attributes_for(:member), company: attributes_for(:company, name: company.name))
#         adder = Cohive::CoworkerAdder.new params: params, space: my_space
#
#         expect{
#           adder.add
#         }.to change{Coworker::Company.count}.by(1)
#       end
#     end
#   end
end
