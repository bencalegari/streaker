class CheckInsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @checkin = @task.check_ins.build
    if @checkin.save
      flash[:notice] = "You checked in!"
      redirect_to tasks_path
    end
  end

end