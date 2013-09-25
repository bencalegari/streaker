class TasksController < ApplicationController

def index
  @task = Task.new
  @tasks = Task.all
end

def new
  @task = Task.new
end

def create
  @task = Task.new(task_params)
  @task.day_list = params[:task][:days]
  if @task.save
    redirect_to tasks_path, notice: "Task created!"
  end
end

def destroy
  @task = Task.find(params[:id])
  @task.destroy
  redirect_to '/tasks'
end

private

def task_params
  params.require(:task).permit(:name, :description, :remindable, :days, :start, :end)
end

end