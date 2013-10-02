class Task < ActiveRecord::Base
  validates_presence_of :name
  acts_as_taggable_on :days, :hours
  belongs_to :user
end
