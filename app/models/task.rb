class Task < ActiveRecord::Base
  validates_presence_of :name
  acts_as_taggable_on :days#, :hours
  belongs_to :user
  has_many :check_ins,
    inverse_of: :task

  def self.create_checkins(user)
    @tasks = Task.where(user_id: user.id)
    @tasks.each do |task|
      task.cleanup_checkins
      if task.last_checkin_creation < Time.now - 1.second
        # task.day_list.add(Time.now.strftime("%A")) # TESTING ONLY. THIS NEEDS TO BE FIXED.
        task.delete_future_checkins
        
        task.day_list.each do |day|
          CheckIn.create(task_id: task.id, start_time: task.create_checkin_start_time(day), end_time: task.create_checkin_end_time(day))
        end
        task.last_checkin_creation = Time.now
      end
    end
  end

  def cleanup_checkins
    missed_check_ins = self.check_ins.where("end_time < ? AND state = ?", Time.now, "pending")
    missed_check_ins.each do |check_in|
      check_in.deny
    end
  end

  def delete_future_checkins
    future_check_ins = self.check_ins.where("start_time > ?", Time.now) 
    future_check_ins.each do |check_in|
      check_in.delete    
    end
  end

  def create_checkin_start_time(day)
    week = (Date.today .. Date.today + 6)
      week.each do |day_of_week|
        if day_of_week.strftime("%A") == day
          return DateTime.new(day_of_week.year, day_of_week.month, day_of_week.day, self.start_time.hour, self.start_time.min )
        end
      end
  end      

  def create_checkin_end_time(day)
    week = (Date.today .. Date.today + 6)
      week.each do |day_of_week|
        if day_of_week.strftime("%A") == day
          return DateTime.new(day_of_week.year, day_of_week.month, day_of_week.day, self.end_time.hour, self.start_time.min )
        end
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

