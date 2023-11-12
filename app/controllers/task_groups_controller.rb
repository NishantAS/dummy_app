class TaskGroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_group, only: %i[ show edit update destroy ]

  def index
    @task_groups = User.find(params[:user_name]).task_groups.all
  end

  def show
  end

  # GET /task_groups/new
  def new
    @task_group = TaskGroup.new
  end

  # GET /task_groups/1/edit
  def edit
  end

  # POST /task_groups or /task_groups.json
  def create
    @task_group = current_user.task_groups.new(task_group_params)

    respond_to do |format|
      if @task_group.save
        format.html { redirect_to user_task_group_path(name: @task_group.name, user_name: @task_group.user_name), notice: "Task group was successfully created." }
        format.json { render :show, status: :created, location: @task_group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_groups/1 or /task_groups/1.json
  def update
    respond_to do |format|
      if @task_group.update(task_group_params)
        format.html { redirect_to user_task_group_path(user_name: @task_group.user_name, name: @task_group.name), notice: "Task group was successfully updated." }
        format.json { render :show, status: :ok, location: @task_group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_groups/1 or /task_groups/1.json
  def destroy
    @task_group.destroy!

    respond_to do |format|
      format.html { redirect_to user_task_groups_path(user_name: current_user.name), notice: "Task group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def done
    @task_group = TaskGroup.find([params[:name], current_user.name])
    @task_group.tasks.update_all done: params[:done]
    redirect_back fallback_location: user_task_groups_path(user_name: @task_group.user_name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_group
      @task_group = current_user.task_groups.find([params[:name], current_user.name])
    end

    # Only allow a list of trusted parameters through.
    def task_group_params
      params.require(:task_group).permit(:name, :description)
    end
end
