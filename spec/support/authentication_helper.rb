module AuthenticationHelper
  def sign_in_as(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(page).not_to have_content "Not Found"

  end

  def create_task
    visit tasks_path
    fill_in "Name", with: "Remember keys."
    fill_in "Description", with: "Just remember them."
    select "Monday"
    select "Friday"
    select('18', :from => "task_start_time_4i")
    select('40', :from => "task_start_time_5i")
    select('19', :from => "task_end_time_4i")
    select('30', :from => "task_end_time_5i")
    click_on "Create Task"
  end
  
end