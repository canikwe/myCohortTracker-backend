class AuthController < ApplicationController
  skip_before_action :authorized?, only: [:create, :google_login]

  def create
    user = User.find_by(name: login_params[:name])

    if user && user.authenticate(login_params[:password])
      token = encode_token({user_id: user.id})

      render json: {user: ApplicationSerializer.new(user).as_json, jwt: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def token_login
    render json: {:status => :accepted}, status: :accepted
  end

  def google_login
    # token = request.headers['Authorization'].split(' ')[1]
    # decoded_token = JWT.decode(token, secret_key_base, false, algorithm: 'HS256')[0]

    if decoded_token['email_verified'] && decoded_token['hd'] == 'flatironschool.com'
      render json: {user: {name: decoded_token['name'], img: decoded_token['picture']}, token: @token}, status: :accepted
    else decoded_token['email_verified']
      render json: {message: 'please sign in with your Flatiron School email'}, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:user).permit(:name, :password)
  end

end
