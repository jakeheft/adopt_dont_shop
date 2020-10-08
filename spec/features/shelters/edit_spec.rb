require 'rails_helper'

describe "As a visitor" do
  describe "When I visit a shelter show page" do
    it "When I click the link 'Update Shelter' Then I am taken to '/shelters/:id/edit' where I see a from to edit the shelter's data including: name, address, city, state, zip" do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211")
      visit "shelters/#{shelter.id}/edit"
      # require "pry"; binding.pry
      click_link("Edit")
      expect("shelters/#{shelter.id}").to eq("shelters/#{shelter.id}/edit")
    end
    it "When I fill out the form with updated information And I click the button to submit the form Then a `PATCH` request is sent to '/shelters/:id', the shelter's info is updated, and I am redirected to the Shelter's Show page where I see the shelter's updated info" do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211")
      visit "shelters/#{shelter.id}/edit"

      fill_in "shelter[name]", with: "Denver Shelter South"
      click_button
      expect("shelters/#{shelter.id}/edit").to eq("shelters/#{shelter.id}")
      expect(page).to have_content("Denver Shelter South")
      expect(page).to have_content("#{shelter.address}")
      expect(page).to have_content("#{shelter.city}")
      expect(page).to have_content("#{shelter.state}")
      expect(page).to have_content("#{shelter.zip}")
    end
  end
end
