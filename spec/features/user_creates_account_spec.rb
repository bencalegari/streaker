require 'spec_helper'

feature 'User creates an account', %q{
  As a potential user
  I want to be able to create an account
  So that I can use the site.
# } do

  # AC:
  # If I am unregistered, I need to provide a valid email and password. 
  # After registration I am signed in to the site. 

  describe "sign up for account" do

    it "allows the user to sign up for an account" do
      visit '/'
      click_on "wanna go streaking?"
      fill_in "Email", with: "user@fake.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      
      click_on "Start Streaking!"
      expect(page).to have_content "Success! Now let's get Streaking."
    end
  end

  describe "sign and access account" do

    it "lets the user sign in after account is registered" do
      user = FactoryGirl.create(:user)
      visit '/'
      click_on "Been here before?"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on "Sign in"
      expect(page).to have_content "Success!" 
    end
  end


end