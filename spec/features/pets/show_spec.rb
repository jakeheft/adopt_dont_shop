require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit '/pets/:id'" do
    it "I see the pet with id including the pet's info" do
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

        visit "/pets/#{pet_1.id}"

        click_link "View Applicants for #{pet_1.name}"

        expect(current_path).to eq("/pets/#{pet_1.id}/applications")
      end
    end
  end
end

describe "As a visitor" do
  describe "If a pet has an approved application on them" do
    it "I can not delete that pet" do
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      shelter_2 = Shelter.create(
        name: "Boulder Shelter",
        address: "123 1st St.",
        city: "Boulder",
        state: "CO",
        zip: "80211"
      )
      pet_1 = Pet.create(
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "Cosmo",
        age: "8",
        sex: "Male",
        status: "Adoptable",
        shelter: shelter_1
      )
      pet_2 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "Zoey",
        age: "9",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter_2
      )
      user = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      application_1 = Application.create(
        user: user,
        status: "Rejected"
      )
      application_2 = Application.create(
        user: user,
        status: "Approved"
      )
      pet_app_1 = PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Rejected"
      )
      pet_app_2 = PetApplication.create(
        pet: pet_2,
        application: application_2,
        pet_application_status: "Approved"
      )

      visit "/pets/#{pet_1.id}"

      click_link "Delete Pet"

      expect(current_path).to eq("/pets")
      expect(page).to have_no_content(pet_1.name)
      expect(PetApplication.where(id: pet_app_1.id)).to eq([])

      visit "/pets/#{pet_2.id}"

      click_link "Delete Pet"

      expect(current_path).to eq("/pets/#{pet_2.id}")
      expect(PetApplication.where(id: pet_app_2.id)).to eq([pet_app_2])
      expect(page).to have_content("This pet cannot be deleted because it is in the process of adoption")
    end
  end
end
