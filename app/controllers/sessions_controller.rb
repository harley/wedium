class SessionsController < ApplicationController
  def create
    if user = User.find_by(email: user_params[:email])
      if user.authenticate(user_params[:password])
        render 'create', locals: {user: user}
      else
        render json: {error: 'Invalid password'}
      end
    else
      render json: {error: 'Invalid email'}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end