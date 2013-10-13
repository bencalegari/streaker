require 'spec_helper'

feature 'User views checkins', %Q{
  As a User
  I want to see my checkins
  To check up on my progress
} do

  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let!(:check_in) { create(:check_in, task_id: task.id) }
  let!(:bad_check_in) { create(:check_in, start_time: Time.now - 2.hours, end_time: Time.now - 1.hour)}

  scenario 'User misses a check in' do
    sign_in_as(user)
    visit tasks_path

    expect(bad_check_in.state).to eql("missed")
  end

end