require 'spec_helper'

feature 'User creates a task', %q{
  As a potential user
  I want to be able to create tasks
  So that I can track them.
 } do
  
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }

  scenario "user creates a task" do
    sign_in_as(user)
    visit tasks_path
    
    expect(Task.find_by(name: "Remember keys.")).to be_present
    expect(page).to have_content(task.name)
  end

  scenario "user sees only their own tasks" do
    other_task = FactoryGirl.create(:task, name: "ZE OTHER TASK", user_id: 500)
    sign_in_as(user)

    expect(page).to have_no_content(other_task.name)
  end

  scenario "user sees an individual task" do
    sign_in_as(user)
    visit tasks_path
    click_on "Show"
    
    expect(page).to have_content("Remember keys.")
  end

  scenario "user deletes a task" do
    sign_in_as(user)
    visit tasks_path
    click_on "Delete"
    
    expect(page).to have_no_content(task.name)
  end

  scenario "user edits a task" do
    sign_in_as(user)
    visit tasks_path
    click_on "Edit"
    fill_in "Name", with: "The newest of names."
    click_on "Update Task"
    expect(task.reload.name).to eql("The newest of names.")
  end

  scenario "creates a task with days and hours" do
    sign_in_as(user)
    create_task

    task = Task.last
    expect(task.day_list).to include("Monday")
    expect(task.day_list).to include("Friday")
    expect(task.start_time.strftime("%H")).to eql("18")
    expect(task.end_time.strftime("%H")).to eql("19")
  end

end