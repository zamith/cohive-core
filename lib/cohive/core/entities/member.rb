require 'cohive/core/serializers/pipeline'

class Member
  attr_accessor :id, :company_id, :name, :email, :phone_no, :boss, :observations,
    :space_id, :created_at, :updated_at

  def initialize(attrs = {})
    attrs.each do |attr_name, attr_value|
      public_send("#{attr_name}=", attr_value)
    end
  end

  def boss?
    !!boss
  end

  def valid?
    # TODO: Add clean validations
    phone_no && name && email
  end

  def errors
    error_messages = []
    error_messages << "missing phone number" unless phone_no
    error_messages << "missing name" unless name
    error_messages << "missing email" unless email
    ValidationErrors.new(error_messages)
  end

  def value
    Serializers::Pipeline.new(self).serialize
  end
end

