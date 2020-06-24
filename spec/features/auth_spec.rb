require 'rails_helper'
require 'faker'

feature 'signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Create User'
  end

  feature 'signing up a new user' do
    before(:each) do
      visit new_user_url
      fill_in 'user[username]', :with => Faker::Name.name
      fill_in 'user[password]', :with => 'password'
      click_on "Create User"
    end

    scenario "redirect to user page after signup complete if valid credentials given" do
        expect(page).to have_content "Welcome to your userpage!"
        expect(current_path).to include("/users/")
    end

  end

  feature 'signing up an invalid user' do
    before(:each) do
      visit new_user_url
      fill_in 'user[username]', :with => 'bad-test-user'
      click_on "Create User"
    end

    scenario "Redirect back to user creation page if invalid credentials given" do
      expect(page).to have_content "Create User"
      expect(current_path). to eq("/users/new")
    end
  end
end
