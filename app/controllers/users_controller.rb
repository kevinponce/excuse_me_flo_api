# frozen_string_literal: true

# handles api endpoint for users
class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: Builders::Json::User.new(user, true).build
    else
      render json: Builders::Json::Errors.new(user).build, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
