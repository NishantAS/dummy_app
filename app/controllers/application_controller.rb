class ApplicationController < ActionController::Base

    private

    def authenticate_user!
        redirect_to new_session_path, notice: "Sign in to do that" unless user_signed_in?
    end

    def unauthenticate_user!
        redirect_to root_path, notice: "Sign out to do that" if user_signed_in?
    end

    def current_user
        Current.user ||= authenticate_user_form_session
    end
    helper_method :current_user

    def authenticate_user_form_session
        User.find(session[:user_name]) if session[:user_name].present?
    end

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def login(user)
        Current.user = user
        reset_session
        session[:user_name] = user.name
    end

    def logout
        Current.user = nil
        reset_session
    end
end
