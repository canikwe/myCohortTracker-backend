class ActivitySerializer < ApplicationController
  def initialize(serialize_object)
    @serialize_object = serialize_object
  end

  def to_json
    @serialize_object.to_json(serialize_options)
  end

  def serialize_options
    {
      except: [:created_at, :updated_at]
    }
  end
end