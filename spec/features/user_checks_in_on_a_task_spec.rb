require 'spec_helper'

feature 'user checks in a task' do
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  scenario 'user makes a valid check in' do
    sign_in_as(user)
    visit tasks_path
    click_on "Check In"

    check_in = CheckIn.last
    expect(page).to have_content("You checked in!")
    expect(check_in.on_time).to be_true
  end
end