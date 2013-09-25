require 'spec_helper'

feature 'User creates a task', %q{
  As a potential user
  I want to be able to create tasks
  So that I can track them.
# } do
  
  let(:user) { FactoryGirl.create(:user) }
  let(:task) { "Remember keys." }

  scenario "user creates a task" do
    sign_in_as(user)
    create_task
    expect(Task.find_by(name: task)).to be_present
    expect(page).to have_content(task)
  end

  scenario "user deletes a task" do
    sign_in_as(user)
    create_task
    click_on "Delete"
    
    expect(page).to have_no_content(task)
  end

  scenario "creates a task with days and hours" do
    sign_in_as(user)
    visit tasks_path
    fill_in "Name", with: task
    fill_in "Description", with: "Just remember them."
    check "Monday"
    check "Friday"
    select('18', :from => "task_start_4i")
    select('40', :from => "task_start_5i")
    select('19', :from => "task_end_4i")
    select('30', :from => "task_end_5i")

    click_on "Create Task"

    task = Task.last
    expect(task.day_list).to include("Monday")
    expect(task.day_list).to include("Friday")
    expect(task.start.strftime("%H")).to eql("18")
    expect(task.end.strftime("%H")).to eql("19")


  end

  def create_task
    visit tasks_path
    fill_in "Name", with: task
    fill_in "Description", with: "Just remember them."
    click_on "Create Task"
  end

end