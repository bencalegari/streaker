class StreakWorker 
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    User.find_each do |user|
      user.check_ins.where(end_time: DateTime.yesterday..DateTime.now).each do |check_in|
        if check_in.state == "missed"
          user.current_streak = 0
        # elsif check_in.state == "pending"
        #   check_in.deny 
        else
          user.current_streak += 1
        end
      end
    end
  end

end
