class EmailConfirmationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_by_token, only: %i[ update ]

    def create
        EmailMailer.with(
            user: current_user,
            token: current_user.generate_token_for(:email_confirmation)
        ).email_confirmation.deliver_later

        redirect_to "#", notice: "Check your email to confirm your email"
    end

    def update
        if @user.update(verified: true)
            redirect_to root_path, notice: "Email has been confirmed"
        else
            redirect_to root_path, alert: "Try again"
        end
    end

    private

    def set_user_by_token
        @user = User.find_by_token_for(:email_confirmation, params[:token])
        redirect_to root_path, alert: "Try again" unless @user.present?
    end
end