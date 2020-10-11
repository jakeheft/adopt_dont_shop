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
