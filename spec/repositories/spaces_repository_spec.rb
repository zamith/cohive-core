require 'spec_helper'
require 'entities/space'

describe "Spaces Repository" do
  let(:repo) { Repository.for(:space) }

  context "#save" do
    it "saves a space" do
      space = Space.new name: "Factory"

      saved_space = repo.save(space)

      expect(repo.find_by_id(saved_space.id)).to eq space
    end
  end
end
