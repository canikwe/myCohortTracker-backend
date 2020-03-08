class AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def create
    instructor = Instructor.find_by(name: login_params[:name])

    if instructor && instructor.authenticate(login_params[:password])
      token = encode_token({instructor_id: instructor.id})

      render json: {instructor: instructor.as_json(serializer_options), jwt: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def token_login
    render json: {:status => :accepted}
  end

  private

  def login_params
    params.require(:instructor).permit(:name, :password)
  end

  def serializer_options
    {except: [:created_at, :updated_at]}
  end

end
