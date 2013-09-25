class Schedule < ActiveRecord::Base
  validates_numericality_of :start
  validates_numericality_of :duration

end
