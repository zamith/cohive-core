class ValidationErrors
  def initialize(error_messages = [])
    @error_messages = error_messages
  end

  def full_messages
    @error_messages
  end

  def size
    0
  end
end
