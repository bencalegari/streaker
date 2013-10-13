class Task < ActiveRecord::Base
  validates_presence_of :name
  acts_as_taggable_on :days, :hours
  belongs_to :user
  has_many :check_ins,
    inverse_of: :task

  def self.create_checkins(user)
    @tasks = Task.where(user_id: user.id)
    @tasks.each do |task|
      task.delete_future_checkins
      
      if task.last_checkin_creation > Time.now - 1.minute
        binding.pry
      end
    end
  end

  def delete_future_checkins
    @check_ins = self.check_ins.where("start_time < ?", Time.now) #THIS SHOULD NOT WORKKKKKK
    @check_ins.each do |check_in|
      binding.pry
      check_in.delete    
    end
  end

end

    

# When checkins are made
  # If the checkins are valid (between the start and end time on the correct day)
    # Update state from pending to on_time
  # Else
    # Reject the update, render the tasks page, flash message Stop overachieving and try again on time!

# When the task index is loaded

  # Create_Checkins class method is called on task
    # Loads all tasks for the user
      # If last_checkin_creation > Time.now - 1.min 
        # Iterate through task.day_list
          # CheckIn.create(task_id: task, state: pending, start_time: METHOD TO GET THE RIGHT TIME end_time: DITTO)
      # End

  # If there are pending checkins
    # If the Time.now > end_time for that check in.
      # Change state from pending to missed
    # End
