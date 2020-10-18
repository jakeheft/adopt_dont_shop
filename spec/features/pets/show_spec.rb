require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit '/pets/:id'" do
    it describe "I see the pet with id including the pet's info" do
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
        status: "Adoptable",
        shelter: shelter)

      visit "/pets/#{pet.id}"

      expect(page).to have_xpath("//img[contains(@src, '#{pet.image}')]")
      expect(page).to have_content(pet.name)
      expect(page).to have_content(pet.description)
      expect(page).to have_content(pet.age)
      expect(page).to have_content(pet.sex)
      expect(page).to have_content(pet.status)
    end
  end
end

describe "As a visitor" do
  describe "When I visit a pets show page" do
    describe "I see a link to view all applications for this pet and when I click the link" do
      it "I can see a list of all the names of applicants for this pet each applicants name is a link to the application's show page" do
        user_1 = User.create!(
          name: "Jake",
          address: "222 1st St.",
          city: "Denver",
          state: "CO",
          zip: "80202"
        )
        user_2 = User.create!(
          name: "Nick",
          address: "224 1st St.",
          city: "Denver",
          state: "CO",
          zip: "80202"
        )
        shelter = Shelter.create(
          name: "Denver Shelter",
          address: "123 Main St.",
          city: "Denver",
          state: "CO",
          zip: "80211"
        )
        pet_1 = Pet.create(
          image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
          name: "Cosmo",
          age: "8",
          sex: "Male",
          status: "Adoptable",
          shelter: shelter
        )
        application_1 = Application.create(
          user: user_1,
          description: "I am awesome",
          status: "Pending"
        )
        application_2 = Application.create(
          user: user_2,
          description: "I am more awesome",
          status: "Pending"
        )
        PetApplication.create(
          pet: pet_1,
          application: application_1,
          pet_application_status: "Pending"
        )

        PetApplication.create(
          pet: pet_1,
          application: application_2,
          pet_application_status: "Pending"
        )

        visit "/pets/#{pet_1.id}"

        expect(page).to have_link(user_1.name)

        click_link "Nick"

        expect(current_path).to eq("/applications/#{application_2.id}")
      end
    end
  end
end
