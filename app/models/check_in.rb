class CheckIn < ActiveRecord::Base
  belongs_to :task

  validates_presence_of :state

  state_machine initial: :pending do
    event :approve do
      transition :pending => :on_time
    end

    event :deny do
      transition :pending => :missed
    end
  end


  def process
    if Time.now >= self.start_time && Time.now <= self.end_time
      self.approve!
    end
  end

end
