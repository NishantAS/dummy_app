class TasksController < ApplicationController
  before_action :authenticate_user!, except: %i[ show ]

  
  def done
    task = Task.find(params[:id])
    task.done= !task.done
    task.save
    redirect_back fallback_location: root_path
  end

  def index
    if params[:group_all] == 'true'
      @tasks = current_user.tasks
    elsif params[:group_name].present?
      @taskgroup = current_user.task_groups.find_by(name: params[:group_name])
      unless @taskgroup.present?
        raise ActionController::RoutingError.new("Not Found")
      else
        @tasks = @taskgroup.tasks
      end 
    else
      @tasks = current_user.task_groups.find_or_create_by(name: current_user.default_task_group_name).tasks
    end

    @tasks = @tasks.where.not(done: params.with_defaults(done: 'true')[:done] == 'true').order_by_time
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = TaskGroup.find([params[:group_name], current_user.name]).tasks.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
    redirect_to root_path, notice: "Task not found" unless @task.present?
  end

  def create
    @task = current_user.tasks.init(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @params = task_params
    @task.title = @params[:title]
    @task.description = @params[:description]
    @start_time = nil
    @start_time = DateTime.parse(@params[:from_time]) if @params[:from_time].present?
    @end_time = nil
    @end_time = DateTime.parse(@params[:to_time]) if @params[:to_time].present?
    @task.during_time = @start_time..@end_time if @start_time.present? || @end_time.present?
    @task.group_name = @params[:group_name]
    @task.private = @params[:private]
    @task
    respond_to do |format|
      if @task.save
        format.html { redirect_to user_task_group_task_path(user_name: @task.user_name, task_group_name: @task.group_name, id: @task.id), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :from_time, :to_time, :group_name, :private)
  end
end
