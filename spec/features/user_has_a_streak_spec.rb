require 'spec_helper'

feature 'User checks in on a task', %Q{
  As a user
  I want to see how consistent I've been with my checkins
  So that I'm motivated to keep going.
  } do

  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before :each do
    sign_in_as(user)
  end

  scenario 'user has checked in two days in a row' do
    visit tasks_path
    click_on "Check In"
    #Fast forward one day
    click_on "Check In"

    expect(page).to have_content("You've been streaking for 1 day!")
  end


end