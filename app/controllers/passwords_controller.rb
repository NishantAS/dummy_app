class PasswordsController < ApplicationController
    before_action :authenticate_user!

    def update
        if current_user.update(password_params)
            redirect_to edit_user_profile_path, notice: "Your password was updated succesfully"
        else
            redirect_to edit_user_profile_path, status: :unprocessable_entity
        end
    end

    private

    def password_params
        params.require(:user).permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: "")
    end

end