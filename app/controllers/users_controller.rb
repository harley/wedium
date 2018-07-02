class UsersController < ApplicationController
  before_action :authenticate_user, only: [:current, :update_current]

  def create
    @user = User.create(user_params)
  end

  def current
    if current_user
      render 'current', locals: { user: current_user }
    else
      render json: {error: "Not authenticated."}, status: 400
    end
  end

  def update_current
    if current_user
      current_user.update(user_update_params)
      if current_user.errors.empty?
        render 'current', locals: { user: current_user }
      else
        render json: {error: current_user.errors.full_messages.to_sentence}
      end
    else
      render json: {error: "Not authenticated."}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def user_update_params
    params.require(:user).permit(:email, :password, :username, :bio, :image)
  end

end
