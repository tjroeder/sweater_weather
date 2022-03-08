class Api::V1::SessionsController < ApplicationController
  before_action :user_params
  before_action :check_for_params

  def create
    user = User.find_by(email: @login[:email])

    if user&.authenticate(@login[:password])
      json_response(UserSerializer.new(user), :ok)
    else
      json_response(invalid_error_msg, :unauthorized)
    end
  end

  private

  def user_params
    @login = params.permit(:email, :password)
    @login[:email].downcase! if @login[:email]
  end

  def check_for_params
    unless @login[:email] && @login[:password]
      error_hash = { errors: [] }

      error_hash[:errors].push({ status: 400, id: 'Email', title: 'Param is missing or the value is empty: email' }) unless @login[:email]

      error_hash[:errors].push({ status: 400, id: 'Password', title: 'Param is missing or the value is empty: password' }) unless @login[:password]
        
      json_response(error_hash, :bad_request)
    end
  end

  def invalid_error_msg
    { 
      errors: [
                { 
                  status: 401, 
                  id: 'login', 
                  title: 'Invalid email and/or password' 
                }
              ] 
    }
  end
end