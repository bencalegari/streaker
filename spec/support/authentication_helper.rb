module AuthenticationHelper
  def sign_in_as(user)
    visit root_path
    click_on "Been here before?"
    # page.should have_selector('#new_user', visible: true)
    within(".sign-up-in-form") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
    end
    click_on "Sign in"
  end
end