class UserSerializer < ApplicationSerializer
  def serializer_options
    {
      except: [:created_at, :updated_at, :password_digest]
    }
  end

  def as_json
    @serialized_object.as_json(serializer_options)
  end
end