require 'spec_helper'

feature 'User checks in on a task', %Q{
  As a user
  I want to check in
  So that I can have a record of when I remembered something.
  } do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let!(:check_in) { create(:check_in, task_id: task.id) }
  let!(:future_check_in) { create(:check_in, start_time: (Time.now + 1.hours), end_time:(Time.now + 2.hours) )}

  scenario 'user makes a check in on time' do
    sign_in_as(user)
    visit tasks_path
    click_on "Check In"

    expect(page).to have_content("You checked in!")
    expect(check_in.reload.state).to eql("on_time")
    expect(CheckIn.where(task_id: task.id).count).to eql(2)
  end

  scenario 'user makes a checkin early' do
    sign_in_as(user)
    visit tasks_path  
    click_on "Check In"

    expect(future_check_in.state).to eql("pending")
    expect(CheckIn.where(task_id: task.id).count).to eql(2)
  end


end