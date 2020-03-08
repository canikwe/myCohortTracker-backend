class ApplicationController < ActionController::API
  # before_action :authorized?

  def encode_token(payload)
    JWT.encode(payload, 'my_s3crt')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_s3crt', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
    # JWT.decode(token, 'my_s3crt')[0]
  end

  def current_instructor
    if decoded_token
      instructor_id = decoded_token[0]['instructor_id']
      @instructor = Instructor.find(instructor_id)
    end
  end

  def logged_in?
    !!current_instructor
  end

  def authorized?
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
