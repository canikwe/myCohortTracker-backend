class ApplicationController < ActionController::API
  before_action :authorized?

  def encode_token(payload)
    JWT.encode(payload, secret_key_base)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
    # JWT.decode(token, 'my_s3crt')[0]
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized?
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def secret_key_base
    if Rails.env == 'development' || Rails.env == 'test'
      Rails.application.credentials.secret_key_base
    else
      ENV['SECRET_KEY_BASE']
  end
end
