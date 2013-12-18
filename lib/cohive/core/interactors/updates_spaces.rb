class UpdatesSpaces
  def initialize(params: {})
    @params = params
    @repo = Repository.for(:space)
  end

  def update(space)
    updated_space = Space.new space.value.merge(params)
    @repo.save updated_space
  end

  private
  attr_reader :params
end
