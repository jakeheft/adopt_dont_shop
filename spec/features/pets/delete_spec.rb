require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a pet show page" do
    describe "I click a link to 'Delete Pet'" do
      it "Directs me to the pet index page where the pet is gone" do
        shelter = Shelter.create(
          name: "Denver Shelter",
          address: "123 Main St.",
          city: "Denver",
          state: "CO",
          zip: "80211")
        pet_1 = Pet.create(
          image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
          name: "Cosmo",
          description: "Cute, cuddly, awesome",
          age: "8",
          sex: "Male",
          status: "Adoptable",
          shelter_name: shelter.name,
          shelter: shelter)
        pet_2 = Pet.create(
          image: "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1649&q=80",
          name: "Frank",
          description: "Mean",
          age: "3",
          sex: "Male",
          status: "Adoptable",
          shelter_name: shelter.name,
          shelter: shelter)

        visit "/pets/#{pet_1.id}"

        click_link "Delete Pet"

        expect(current_path).to eq("/pets")
        expect(page).to have_no_content("Cosmo")
        expect(page).to have_no_content("8")
        expect(page).to have_content("Frank")
        expect(page).to have_content("3")
      end
    end
  end
end
