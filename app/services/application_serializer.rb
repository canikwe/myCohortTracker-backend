class ApplicationSerializer < ApplicationController

  def initialize(serialize_object)
    @serialize_object = serialize_object
  end

  def serializer_options
    {
      except: [:created_at, :updated_at]
    }
  end

  def to_json
    @serialize_object.to_json(serializer_options)
  end

  def as_json
    @serialize_object.as_json(serializer_options)
  end

end