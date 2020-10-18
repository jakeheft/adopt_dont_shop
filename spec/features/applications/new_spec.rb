require 'rails_helper'

describe "As a visitor," do
  describe "When I visit '/applications/new'" do
    describe "And I fill out and submit the form" do
      it "Then I am taken to the new application's show page where I see my user, all address info and an indicator that the application is 'In Progress'" do
        user = User.create(
          name: "Jake",
          address: "222 1st St.",
          city: "Denver",
          state: "CO",
          zip: "80202"
        )

        visit 'applications/new'

        fill_in "user_name", with: user.name

        click_button 'Create Application'

        application = Application.last

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.full_address)
        expect(page).to have_content('In Progress')
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit the new application page" do
    describe "And I fill in the form with the name of a User that doesn't exist in the database When I click submit" do
      it "Then I am taken back to the new applications page And I see a message that the user could not be found." do
        visit "/applications/new"

        fill_in "user_name", with: "Jimbo"

        click_button "Create Application"

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Please enter a user name that matches an existing user")
      end
    end
  end
end
