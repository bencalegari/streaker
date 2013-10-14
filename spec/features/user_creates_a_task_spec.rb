require 'spec_helper'

feature 'User creates a task', %q{
  As a potential user
  I want to be able to create tasks
  So that I can track them.
 } do
  
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let!(:old_check_in) { create(:check_in, task_id: task.id, start_time: Time.now + 10.hours, end_time: Time.now + 11.hours) }

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

  scenario "user changes days and times for task" do
    sign_in_as(user)
    visit tasks_path
    click_on "Edit"
    
    fill_in "Name", with: "The newest of names."
    fill_in "Description", with: "Stuffff"
    check "Tuesday"
    check "Saturday"
    select('12', :from => "task_start_time_4i")
    select('30', :from => "task_start_time_5i")
    select('15', :from => "task_end_time_4i")
    select('30', :from => "task_end_time_5i")
    click_on "Update Task"

    expect(task.reload.name).to eql("The newest of names.")
    new_check_in = CheckIn.last
    expect(new_check_in.start_time.hour).to eql(task.reload.start_time.hour)
    expect(new_check_in.start_time.min).to eql(task.reload.start_time.min)
    expect(new_check_in.end_time.hour).to eql(task.reload.end_time.hour)
    expect(new_check_in.end_time.min).to eql(task.reload.end_time.min)
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