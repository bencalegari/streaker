class Task < ActiveRecord::Base
  validates_presence_of :name
  acts_as_taggable_on :days, :hours
  belongs_to :user
  has_many :check_ins,
    inverse_of: :task

  def self.check_tasks(user)
    @checkins = CheckIn.where("on_time = ? AND created_at > ?", false, user.last_sign_in_at)
    @checkins.each do |checkin|
      if (checkin.task.start_time < checkin.created_at && checkin.task.end_time > checkin.created_at)

      end
    end
  end

end
