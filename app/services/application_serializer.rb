class ApplicationSerializer < ApplicationController

  def initialize(serialize_object)
    @serialize_object = serialize_object
  end

  def serializer_options
    {
      except: [:created_at, :updated_at]
    }
  end

  def to_serialize_json(options)
    @serialize_object.to_json(options)
  end

  def as_serialize_json(options)
    @serialize_object.as_json(options)
  end

end