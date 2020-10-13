require 'rails_helper'

# As a visitor
# When I visit '/users/new'
# I see a form to create a new user
# When I fill in the form with my
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip
# Then I am taken to my new user's show page
# And I see all of the information I entered in the form

RSpec.describe "As a visitor" do
  describe "When I visit '/users/new' I see a form to create a new user" do
    it "When I fill in the form I'm taken to the user show page to see info" do
      # user =User.create(
      #   name: "Jake",
      #   address: "222 1st St.",
      #   city: "Denver",
      #   state: "CO",
      #   zip: "80202"
      # )

      visit "/users/new"

      fill_in "user_name", with: "Jake"
      fill_in "user_address", with: "222 1st St."
      fill_in "user_city", with: "Denver"
      fill_in "user_state", with: "CO"
      fill_in "user_zip", with: "80202"

      click_button "Create User"
      # save_and_open_page
      # require "pry"; binding.pry
      expect(current_path).to eq("/users/#{User.last.id}") #what goes here?
      expect(page).to have_content("Jake")
      expect(page).to have_content("222 1st St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80202")
    end
  end
end
