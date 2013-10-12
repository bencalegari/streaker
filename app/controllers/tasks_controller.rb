class TasksController < ApplicationController

def index
  @task = Task.new
  @tasks = Task.where(:user_id => current_user.id)
  @check_in = CheckIn.new
end

def new
  @task = Task.new
end

def create
  @task = Task.new(task_params)
  @task.day_list = params[:task][:days]
  @task.user = current_user
  @task.last_checkin_creation = Time.now
  
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

def process_checkin
  binding.pry
  @checkins = CheckIn.where(task_id: params[:task_id])
end

private

def task_params
  params.require(:task).permit(:name, :description, :remindable, :days, :start_time, :end_time)
end

end