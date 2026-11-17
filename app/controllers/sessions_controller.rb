
class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[create]

  rate_limit to: 10,
             within: 3.minutes,
             only: :create,
             with: -> {
               render json: { error: "Too many login attempts. Try again later." },
                      status: :too_many_requests
             }

  def create
    user = User.authenticate_by(
      params.permit(:email_address, :password)
    )

    if user
      start_new_session_for(user)

      render json: {
        message: "Login successful",
        user: {
          id: user.id,
          display_name: user.display_name,
          email_address: user.email_address
        }
      }, status: :ok
    else
      render json: {
        error: "Invalid email address or password"
      }, status: :unauthorized
    end
  end

  def destroy
    terminate_session

    render json: {
      message: "Logged out successfully"
    }, status: :ok
  end
end
