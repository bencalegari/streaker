require 'spec_helper'

feature 'User views checkins', %Q{
  As a User
  I want to see my checkins
  To check up on my progress
} do

  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user,) }
  let!(:check_in) { create(:check_in, task_id: task.id) }
  let!(:bad_check_in) { create(:check_in, task_id: task.id, start_time: Time.now - 2.hours, end_time: Time.now - 1.hour)}
  let!(:future_check_in) {create(:check_in, task_id: task.id, start_time: Time.now + 5.days, end_time: Time.now + 6.days)}

  scenario 'User misses a check in' do
    sign_in_as(user)
    visit tasks_path

    expect(bad_check_in.reload.state).to eql("missed")
  end

  scenario 'User checks the index page' do
    check_in_count = CheckIn.count
    sign_in_as(user)
    visit tasks_path
    
    expect(CheckIn.count).to eql(check_in_count)
  end

end