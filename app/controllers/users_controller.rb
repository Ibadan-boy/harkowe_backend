class UsersController < ApplicationController
    def create #method to create a new user

        user = User.new(user_params) #create new user object

        if user.save
            render json: {
                message: "User created successfully",
                user: {
                    id: user.id,
                    display_name: user.display_name,
                    email_address: user.email_address
                }

            }, status: :created #return the user object as JSON with a 201 status code

        else
            render json: { errors: user.errors.full_messages }, 
            status: :unprocessable_entity #return the error messages as JSON with a 422 status code
        end

    end

    private

    def user_params
        params.require(:user).
        permit(:display_name, 
        :email_address, 
        :password, 
        :password_confirmation) #permit the required parameters for user creation
    end
end
