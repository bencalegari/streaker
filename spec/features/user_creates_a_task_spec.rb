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
    visit tasks_path
    fill_in "Name", with: task
    fill_in "Description", with: "Just remember them."
    click_on "Create Task"

    expect(Task.find_by(name: task)).to be_present
    expect(page).to have_content(task)
  end

end