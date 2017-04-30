class AuthenticationController < ApplicationController
  def login
    user = User.find_for_database_authentication(email: params[:email])
    if user.present? && user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  # refactor this away from here!
  def payload(user)
    return nil unless user and user.id
    {
      token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end
end
