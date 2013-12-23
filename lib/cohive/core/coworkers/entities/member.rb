require 'active_model'
require 'serializers/pipeline'

module Coworkers
  class Member
    ATTRIBUTES = [:id, :company_id, :name, :email, :phone_no, :boss, :observations, :space_id, :created_at, :updated_at]

    include ActiveModel::Validations

    attr_accessor *ATTRIBUTES
    validates_presence_of :phone_no, :name, :email

    def initialize(attrs = {})
      attrs.each do |attr_name, attr_value|
        public_send("#{attr_name}=", attr_value)
      end
    end

    def boss?
      !!boss
    end

    def value
      Serializers::Pipeline.new(self).serialize
    end

    def attributes
      ATTRIBUTES
    end
  end
end

