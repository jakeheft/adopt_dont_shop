require 'rails_helper'

RSpec.describe "When I visit a Pet Show page" do
  describe "I see a link to update that Pet 'Update Pet'" do
    describe "When I click the link I am taken to '/pets/:id/edit' to a form to edit the pet's data" do
      it "When I click the button to 'Update Pet' I'm taken to the pet show page to see updated data" do
        shelter = Shelter.create(
          name: "Denver Shelter",
          address: "123 Main St.",
          city: "Denver",
          state: "CO",
          zip: "80211")
        pet =Pet.create(
          image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
          name: "Cosmo",
          description: "Cute, cuddly, awesome",
          age: "8",
          sex: "Male",
          status: "Adoptable",
          shelter_name: shelter.name,
          shelter: shelter)

        visit "/pets/#{pet.id}"

        click_link "Update Pet"

        expect(current_path).to eq("/pets/#{pet.id}/edit")

        fill_in "pet_age", with: "7"
        fill_in "pet_description", with: "Cute, cuddly, super awesome"

        click_button

        expect(current_path).to eq("/pets/#{pet.id}")
        expect(page).to have_content("7")
        expect(page).to have_content("Cute, cuddly, super awesome")
      end
    end
  end
end
