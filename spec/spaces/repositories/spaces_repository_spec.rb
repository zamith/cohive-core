require 'spec_helper'
require 'spaces/entities/space'

describe "Spaces Repository" do
  let(:repo) { Repository.for(:space) }

  context "#save" do
    it "saves a space" do
      space = ::Spaces::Space.new name: "Factory"

      saved_space = repo.save(space)

      expect(repo.find_by_id(saved_space.id)).to eq space
    end
  end
end
