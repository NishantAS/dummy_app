class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[ edit update destroy ]

  def show
    @user = User.find(params[:name])
    redirect_to root_path unless @user.present?
  end

  def profile
    @user = current_user
  end

  def new
    @user = User.new
  end

  def search
    @user = User.find_by(name: params[:name])
    if @user.present?
      redirect_to user_path(@user)
    else
      redirect_to root_path, notice: "User not found"
    end
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_create_params)

    respond_to do |format|
      if @user.save
        login @user
        format.html { redirect_to root_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        gon.errors = @user.errors.each
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.update(user_update_params)
        logout
        login User.find_by(user_update_params)
        format.html { redirect_to user_url(current_user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: current_user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.authenticate_by(name: current_user.name, password: params[:password])
    
    respond_to do |format|
      if @user.present?
        logout
        @user.destroy!
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to user_profile_path, alert: "Password incorrect"}
        format.json { head :no_content }
      end
    end
  end

  private

    def user_create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_params
        params.require(:user).permit(:name, :email)
    end
end
