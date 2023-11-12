class SessionsController < ApplicationController

    def new
    end

    def create
        if params[:email_or_user_name][/\A[^\s@]{4,16}\z/].present?
            params[:name] = params[:email_or_user_name]
        elsif params[:email_or_user_name].strip.downcase[/\A[a-z0-9+_.-]+@([a-z0-9]+\.)+[a-z]{2,6}\z/].present?
            params[:name] = User.find_by(email: params[:email])
        end
        
        respond_to do |format|
            if @user = User.authenticate_by(name: params[:name], password: params[:password])
                login @user
                format.html { redirect_to root_path, notice: "You have been signed in." }
                format.json { render json: @user, status: :created, location: @user }
            else
                flash[:alert] = "Incorrect email or password"
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        logout
        redirect_to root_path, notice: "You have been logged out."
    end

end