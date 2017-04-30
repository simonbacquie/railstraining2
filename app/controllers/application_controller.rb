class ApplicationController < ActionController::Base

  # so that we can get the @current_user instance variable from anywhere
  attr_reader :current_user

  protected
  def authenticate_request!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private
  def passed_in_token
      @passed_in_token ||= if request.headers['Authorization'].present?
        # so that it still works if they put "Bearer " before the token
        request.headers['Authorization'].split(' ').last
      end
  end

  def decoded_token
    @decoded_token ||= JsonWebToken.decode(passed_in_token)
  end

  def user_id_in_token?
    passed_in_token && decoded_token && decoded_token[:user_id].present?
  end

end
