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
  redirect_to tasks_path, notice: "Task deleted."
end

def process_checkin
  @check_ins = CheckIn.where(task_id: params[:task_id])
  @check_ins.each do |check_in|
    check_in.process
  end
  redirect_to tasks_path, notice: "You checked in!"
end

private

def task_params
  params.require(:task).permit(:name, :description, :remindable, :days, :start_time, :end_time)
end

end