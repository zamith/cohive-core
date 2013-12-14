require 'cohive/core/serializers/pipeline'

class Member
  attr_accessor :id, :company_id, :name, :email, :phone_no, :boss, :observations,
    :space_id, :created_at, :updated_at

  def initialize(attrs = {})
    attrs.each do |attr_name, attr_value|
      public_send("#{attr_name}=", attr_value)
    end
  end

  def valid?
    # TODO: Add clean validations
    return false unless phone_no
    true
  end

  def errors
    # TODO: Create correct error messages
    ValidationErrors.new
  end

  def value
    Serializers::Pipeline.new(self).serialize
  end
end

class ValidationErrors
  def full_messages
    []
  end

  def size
    0
  end
end
