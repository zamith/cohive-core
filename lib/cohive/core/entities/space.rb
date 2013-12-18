require 'cohive/core/serializers/pipeline'

class Space
  attr_accessor :id, :name

  def initialize(attrs = {})
    attrs.each do |attr_name, attr_value|
      public_send("#{attr_name}=", attr_value)
    end
  end

  def value
    Serializers::Pipeline.new(self).serialize
  end
end
