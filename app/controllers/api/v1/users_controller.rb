class Api::V1::UsersController < ApplicationController
  before_action :user_params

  def create
    new_user = User.new(@user)

    if new_user.save
      json_response(UserSerializer.new(new_user), :created)
    else
      error_hash = ErrorSerializer.serialize(new_user.errors, 400, request.env['PATH_INFO'])
      json_response(error_hash, :bad_request)
    end
  end

  private

  def user_params
    @user = params.permit(:email, :password, :password_confirmation)
    @user[:email].downcase! if @user[:email]
  end
end