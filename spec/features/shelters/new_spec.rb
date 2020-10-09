require 'rails_helper'

describe "When I visit the Shelter index page and click the link for 'New Shelter'" do
  describe "I am taken to '/shelters/new' to create a new shelter" do
    it "I fill out the form and click submit where I can see the new shelter listed on the shelter index" do

      visit "/shelters"

      click_link("New Shelter")

      expect(current_path).to eq ("/shelters/new")

      fill_in "shelter[name]", with: "Ugly Pet Shelter"
      fill_in "shelter[address]", with: "234 Rodeo Dr."
      fill_in "shelter[city]", with: "Denver"
      fill_in "shelter[state]", with: "CO"
      fill_in "shelter[zip]", with: "88888"

      click_button

      expect(current_path).to eq ("/shelters")
      expect(page).to have_content("Ugly Pet Shelter")
    end
  end
end
