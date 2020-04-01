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
      @token = auth_header.split(' ')[1]
      begin
        JWT.decode(@token, secret_key_base, false, algorithm: 'HS256')[0]
      rescue JWT::DecodeError
        nil
      end
    end
    # if auth_header
    #   token = auth_header.split(' ')[1]
    #   begin
    #     JWT.decode(token, secret_key_base, true, algorithm: 'HS256')
    #   rescue JWT::DecodeError
    #     nil
    #   end
    # end
  end

  def current_user
    if decoded_token
      {
        'name' => decoded_token['name'],
        'img' => decoded_token['picture'],
        'email': decoded_token['email']
      }
    end
    # if decoded_token
    #   user_id = decoded_token[0]['user_id']
    #   @user = User.find(user_id)
    # end
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

  def compliment_user
    res = RestClient.get 'https://complimentr.com/api'
    parse_res = JSON.parse(res)
    parse_res["compliment"]
  end
end
