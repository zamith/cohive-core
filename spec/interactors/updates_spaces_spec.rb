require 'spec_helper'
require 'interactors/updates_spaces'
require 'entities/space'

describe UpdatesSpaces do
  let(:repo) { Repository.for(:space) }

  after :each do
    repo.clear
  end

  it "receives no params and does nothing" do
    saved_space = repo.save Space.new(name: "Factory")
    updater = UpdatesSpaces.new(params: {})

    expect {
      updater.update(saved_space)
    }.not_to change{repo.all.size}
  end

  it "receives a space and updates it according to the params" do
    saved_space = repo.save Space.new(name: "Factory")
    new_name = 'Cowork X'
    updater = UpdatesSpaces.new(params: {name: new_name})

    updater.update(saved_space)

    expect(repo.find_by_id(saved_space.id).name).to eq new_name
  end
end
