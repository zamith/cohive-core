require 'spec_helper'
require 'interactors/updates_spaces'
require 'helpers/coworker_params'

describe UpdatesSpaces do
  let(:repo) { Repository.for(:space) }

  after :each do
    repo.clear
  end

  it "receives no params and does nothing" do
    updater = UpdatesSpaces.new(params: {})

    expect {
      updater.update
    }.not_to change{repo.all.size}
  end
end
