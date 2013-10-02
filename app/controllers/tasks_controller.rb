class TasksController < ApplicationController

def index
  @task = Task.new
  @tasks = Task.where(:user_id => current_user.id)
end

def new
  @task = Task.new
end

def create
  @task = Task.new(task_params)
  @task.day_list = params[:task][:days]
  @task.user_id = current_user.id
  
  if @task.save
    redirect_to tasks_path, notice: "Task created!"
  end
end

def show
  @task = Task.find(params[:id])
end

def destroy
  @task = Task.find(params[:id])
  @task.destroy
  redirect_to '/tasks'
end

private

def task_params
  params.require(:task).permit(:name, :description, :remindable, :days, :start_time, :end_time)
end

end