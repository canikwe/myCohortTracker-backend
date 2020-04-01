class GroupSerializer < ApplicationSerializer
  def serializer_options
    {
      except: [:created_at, :updated_at, :activity_id],
      include: [
        {
          :activity => {
            except: [:created_at, :updated_at]
          }
        }
      ],
      methods: [:student_ids]
    }
  end

  def to_json
    @serialize_object.to_json(serializer_options)
  end

  def as_json
    @serialize_object.as_json(serializer_options)
  end
end