class Task < ActiveRecord::Base
  validates_presence_of :name
  acts_as_taggable_on :days#, :hours
  belongs_to :user
  has_many :check_ins,
    inverse_of: :task

  def self.create_checkins(user)
    @tasks = Task.where(user_id: user.id)
    @tasks.each do |task|
      task.check_checkins
      task.delete_future_checkins
      task.day_list.each do |day|
        if CheckIn.where("task_id = ? and date_trunc('minute', start_time) = date_trunc('minute', cast(? as timestamp)) and date_trunc('minute', end_time) = date_trunc('minute', cast(? as timestamp)) ", task.id, task.create_checkin_start_time(day), task.create_checkin_end_time(day)).empty?
          CheckIn.create(task_id: task.id, start_time: task.create_checkin_start_time(day), end_time: task.create_checkin_end_time(day))
        end
      end
    end
  end

  def check_checkins
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
          return DateTime.new(day_of_week.year, day_of_week.month, day_of_week.day, self.end_time.hour, self.end_time.min )
        end
      end
  end
end
