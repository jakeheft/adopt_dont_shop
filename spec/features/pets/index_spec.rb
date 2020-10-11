require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit '/pets'" do
    it "I see each pet in the system and their info" do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211")
      pet = Pet.create(
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "Cosmo",
        age: "8",
        sex: "Male",
        shelter_name: shelter.name,
        shelter: shelter
        )

        visit '/pets'

        expect(page).to have_xpath("//img[contains(@src, '#{pet.image}')]")
        expect(page).to have_content(pet.name)
        expect(page).to have_content(pet.age)
        expect(page).to have_content(pet.sex)
        expect(page).to have_content(pet.shelter_name)
    end
  end
end

RSpec.describe "As a visitor" do
  describe "When I visit the pets index page or a shelter pets index page" do
    describe "Next to every pet, I see a link to edit that pet's info" do
      it "When I click the link I'm taken to that pets edit page to update its information" do
        shelter = Shelter.create(
          name: "Denver Shelter",
          address: "123 Main St.",
          city: "Denver",
          state: "CO",
          zip: "80211")
        pet = Pet.create(
          image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
          name: "Cosmo",
          age: "8",
          sex: "Male",
          shelter_name: shelter.name,
          shelter: shelter)

        visit "/pets"

        click_link "Edit Pet"

        expect(current_path).to eq("/pets/#{pet.id}")

        visit "/shelters/#{shelter.id}/pets"

        click_link "Edit Pet"

        expect(current_path).to eq("/pets/#{pet.id}")
      end
    end
  end
end
