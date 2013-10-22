require 'spec_helper'

feature 'User creates a task', %q{
  As a potential user
  I want to be able to create tasks
  So that I can track them.
 } do
  
  let(:user) { create(:user) }
  let!(:task) { create(:task, user: user) }
  let!(:old_check_in) { create(:check_in, task_id: task.id, start_time: Time.now + 10.hours, end_time: Time.now + 11.hours) }

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

  scenario "user changes days and times for task" do
    click_on "Edit"
    fill_in "Name", with: "The newest of names."
    fill_in "Description", with: "Stuffff"
    within(".task_days") do
      select "Tuesday"
      select "Saturday"
    end
    # page.execute_script("$('#task_start_time').val('12:00 PM')")
    # page.execute_script("$('#task_start_time').val('2:00 PM')")
    click_on "Update Task"
    visit tasks_path

    expect(task.reload.name).to eql("The newest of names.")
    new_check_in = CheckIn.last
    
    # expect(new_check_in.start_time.hour).to eql(task.reload.start_time.hour)
    # expect(new_check_in.start_time.min).to eql(task.reload.start_time.min)
    # expect(new_check_in.end_time.hour).to eql(task.reload.end_time.hour)
    # expect(new_check_in.end_time.min).to eql(task.reload.end_time.min)
  end

  # scenario "creates a task with days and hours" do
  #   visit tasks_path
  #   fill_in "Name", with: "Remember keys."
  #   fill_in "Description", with: "Just remember them."
  #   select "Monday"
  #   select "Friday"
  #   page.execute_script("$('#task_start_time').val('6:30 PM')")
  #   page.execute_script("$('#task_start_time').val('7:30 PM')")
  #   click_on "Create Task"

  #   task = Task.last
  #   expect(task.day_list).to include("Monday")
  #   expect(task.day_list).to include("Friday")
  #   expect(task.start_time.strftime("%H")).to eql("18")
  #   expect(task.end_time.strftime("%H")).to eql("19")
  # end

end