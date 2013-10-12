require 'spec_helper'

feature 'user checks in a task' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let!(:check_in) { create(:check_in, task_id: task.id) }

  scenario 'user makes a check in on time' do
    sign_in_as(user)
    visit tasks_path
    click_on "Check In"

    expect(page).to have_content("You checked in!")
    expect(check_in.state).to eql("on_time")
  end

  scenario 'user makes a checkin late or early' do

  end

end