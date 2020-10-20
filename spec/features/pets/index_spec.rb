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
        shelter: shelter
        )

        visit '/pets'

        expect(page).to have_xpath("//img[contains(@src, '#{pet.image}')]")
        expect(page).to have_content(pet.name)
        expect(page).to have_content(pet.age)
        expect(page).to have_content(pet.sex)
        expect(page).to have_content(pet.shelter.name)
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
          shelter: shelter)

        visit "/pets"

        click_link "Edit Pet"

        expect(current_path).to eq("/pets/#{pet.id}/edit")

        visit "/shelters/#{shelter.id}/pets"

        click_link "Edit Pet"

        expect(current_path).to eq("/pets/#{pet.id}/edit")
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit the pets index page I see a delete link next to each pet" do
    it "When I click the link I'm returned to '/pets' and that pet is gone" do
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
        shelter: shelter)
      pet_2 = Pet.create(
        image: "https://images.unsplash.com/photo-1583511655857-d19b40a7a54e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1649&q=80",
        name: "Frank",
        description: "Mean",
        age: "3",
        sex: "Male",
        status: "Adoptable",
        shelter: shelter)

      visit "pets/"

      click_link("Delete Pet", match: :first)

      expect(current_path).to eq ("/pets")
      expect(page).to have_no_content("Cosmo")
      expect(page).to have_content("Frank")
    end
  end
end

describe "As a visitor" do
  describe "When I visit the pet index page" do
    describe "And I click the link to 'Start an Application'" do
      it "Then I am taken to the new application page where I see a form" do
        visit '/pets'

        click_link('Start an Application')

        expect(current_path).to eq('/applications/new')
      end
    end
  end
end
