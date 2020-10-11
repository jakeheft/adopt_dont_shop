require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a shelter page and click 'Create Pet' link, I'm taken to '/shelters/:shelter_id/pets/new'" do
    describe "When I fill out a new pet and click 'Create Pet' button" do
      describe "I'm redirected to the shelter pets index page" do
        it "On this page, I see the new pet attributes with a status of adoptable" do

          shelter = Shelter.create(
            name: "Denver Shelter",
            address: "123 Main St.",
            city: "Denver",
            state: "CO",
            zip: "80211")

          visit "/shelters/#{shelter.id}/pets"

          click_link "Create Pet"

          expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")

          fill_in "pet_image", with: "https://images.unsplash.com/photo-1524511751214-b0a384dd9afe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2767&q=80"
          fill_in "pet_name", with: "Charlie"
          fill_in "pet_description", with: "Wiley dog who loves to fetch"
          fill_in "pet_age", with: "5"
          fill_in "pet_sex", with: "Female"

          click_button

          expect(current_path).to eq("/shelters/#{shelter.id}/pets")

          expect(page).to have_content("Pets at #{shelter.name}")
          expect(page).to have_xpath("//img[contains(@src, 'https://images.unsplash.com/photo-1524511751214-b0a384dd9afe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2767&q=80')]")
          expect(page).to have_content("Charlie")
          expect(page).to have_content("Wiley dog who loves to fetch")
          expect(page).to have_content("5")
          expect(page).to have_content("Female")
          expect(page).to have_content("Adoptable")
        end
      end
    end
  end
end
