class AuthController < ApplicationController
  skip_before_action :authorized?, only: [:create]

  def create
    user = User.find_by(name: login_params[:name])

    if user && user.authenticate(login_params[:password])
      token = encode_token({user_id: user.id})

      render json: {user: user.as_json(serializer_options), jwt: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def token_login
    render json: {:status => :accepted}, status: :accepted
  end

  private

  def login_params
    params.require(:user).permit(:name, :password)
  end

  def serializer_options
    {except: [:created_at, :updated_at]}
  end

end
