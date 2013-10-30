require 'spec_helper'

feature 'User views checkins', %Q{
  As a User
  I want to see my checkins
  To check up on my progress
} do

  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user,) }

  scenario 'User misses a check in' do
    sign_in_as(user)
    old_task = FactoryGirl.create(:task, user: user, start_time: Time.now - 6.hours, end_time: Time.now - 5.hours )
    visit tasks_path

    expect(CheckIn.last.reload.state).to eql("missed")
  end

  scenario 'User checks the index page' do
    check_in_count = CheckIn.count
    sign_in_as(user)
    
    expect(CheckIn.count).to eql(2)
  end

  scenario 'User sees their missed checkins' do
    sign_in_as(user)
    old_task = FactoryGirl.create(:task, user: user, start_time: Time.now - 6.hours, end_time: Time.now - 5.hours )
    visit tasks_path

    expect(page).to have_css(".missed")
  end

  scenario 'User sees their successful checkins' do
    sign_in_as(user)
    click_on "Check In"

    expect(page).to have_selector(".on-time")
  end

  scenario 'User sees their pending checkins' do
    sign_in_as(user)
    expect(page).to have_css(".pending")
  end

end
