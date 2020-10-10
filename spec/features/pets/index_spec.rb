require 'rails_helper'

# As a visitor
# When I visit '/pets'
# Then I see each Pet in the system including the Pet's:
# - image
# - name
# - approximate age
# - sex
# - name of the shelter where the pet is currently located

RSpec.describe "As a visitor" do
  describe "When I visit '/pets'" do
    it "I see each pet in the system and their info" do
      pet = Pet.create({
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "Cosmo",
        age: "8",
        sex: "Male",
        shelter: "Denver Shelter"
        })

        visit '/pets'

        expect(page).to have_content(pet.image)
        expect(page).to have_content(pet.name)
        expect(page).to have_content(pet.age)
        expect(page).to have_content(pet.sex)
        expect(page).to have_content(pet.shelter)
    end
  end
end
