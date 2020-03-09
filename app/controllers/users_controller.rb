class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token({ user_id: user.id })
      render json: {user: user.as_json(serializer_options), jwt: token}, status: :created
    else
      render json: {error: 'failed to create user'}, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end

  def serializer_options
    {except: [:created_at, :updated_at, :password_digest]}
  end
end
