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
  if @task.save
    redirect_to tasks_path, notice: "Task created!"
  end
end

private

def task_params
  params.require(:task).permit(:name, :description, :remindable)
end

end