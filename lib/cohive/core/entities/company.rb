require 'cohive/core/serializers/pipeline'

class Company
  attr_accessor :id, :name, :space_id

  def initialize(attrs = {})
    attrs.each do |attr_name, attr_value|
      public_send("#{attr_name}=", attr_value)
    end
  end

  def value
    Serializers::Pipeline.new(self).serialize
  end
end
