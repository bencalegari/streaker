class SessionsController < Devise::SessionsController

  def create
    super
    if current_user
      Task.check_tasks(current_user)
      # CheckinWorker.perform_async(current_user.id)
    end
  end

end