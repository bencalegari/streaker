require 'spec_helper'

feature 'User creates a task', %q{
  As a potential user
  I want to be able to create tasks
  So that I can track them.
 } do
  
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  before :each do
    sign_in_as(user)
  end

  scenario "user creates a task" do
    visit tasks_path
    
    expect(Task.find_by(name: "Remember keys.")).to be_present
    expect(page).to have_content(task.name)
  end

  scenario "user sees only their own tasks" do
    other_task = FactoryGirl.create(:task, name: "ZE OTHER TASK", user_id: 500)
  
    expect(page).to have_no_content(other_task.name)
  end

  scenario "user sees an individual task" do
    visit tasks_path
    click_on "Show"

    expect(page).to have_content("Remember keys.")
  end

  scenario "user deletes a task" do
    visit tasks_path
    click_on "Delete"
    
    expect(page).to have_no_content(task.name)
  end

  scenario "user creates a task with a checkin to complete at that current time" do
    visit tasks_path
    click_on "Check In"
    
    expect(CheckIn.first.state).to eql("on_time")
  end

  scenario "user changes days and times for task" do
    click_on "Edit"
    fill_in "Name", with: "The newest of names."
    fill_in "Description", with: "Stuffff"
    within(".task_days") do
      select "Tuesday"
      select "Saturday"
    end
    click_on "Update Task"
    visit tasks_path

    expect(task.reload.name).to eql("The newest of names.")
    new_check_in = CheckIn.last
    
  end


end