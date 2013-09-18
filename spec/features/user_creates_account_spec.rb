require 'spec_helper'

feature 'User creates an account', %q{
  As a potential user
  I want to be able to create an
  So that I can use the site.
# } do
  # As an unregistered user
  # I want to make an account
  # To start tracking my tasks

  # AC:
  # If I am unregistered, I need to provide a valid email and password. 
  # After registration I am signed in to the site. 

  describe "sign up for account" do

    it "shows a field for username and password" do
      visit '/'
      click_on "Sign up"
      fill_in "Email", with: "user@fake.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      # save_and_open_page
      click_on "Start Streaking!"
      expect(page).to have_content "Success!"
    end
  end


end