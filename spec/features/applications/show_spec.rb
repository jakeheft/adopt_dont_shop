require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an applications show page '/applications/:id'" do
    it "Then I can see user name, user address, description, pets applied for, and status" do
      user = User.create!(
        name: "Jake",
        address: "222 1st St.",
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
      pet_2 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "Zoey",
        age: "9",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter
      )
      application = Application.create(
        user: user,
        description: "I am awesome",
        status: "In Progress"
      )
      PetApplication.create(
        pet: pet_1,
        application: application
      )
      PetApplication.create(
        pet: pet_2,
        application: application
      )

      visit "/applications/#{application.id}"

      expect(page).to have_content(user.name)
      expect(page).to have_content(user.full_address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.status)
      expect(page).to have_link("Cosmo")
      expect(page).to have_link("Zoey")

      click_link "Zoey"

      expect(current_path).to eq("/pets/#{pet_2.id}")
    end
  end
end

describe "As a visitor" do
  describe "When I visit an application's show page and that application has not been submitted," do
    describe "Then I see a section on the page to 'add a Pet to this Application' with an input to search for pets by name" do
      describe "When I fill in this field with a Pet's name and I click submit," do
        it "Then I am taken back to the application show page and under the search bar I see any Pet whose name matches my search" do
          user = User.create!(
            name: "Jake",
            address: "222 1st St.",
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
          pet_2 = Pet.create(
            image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
            name: "Zoey",
            age: "9",
            sex: "Female",
            status: "Adoptable",
            shelter: shelter
          )
          application = Application.create(
            user: user,
            description: "I am awesome",
            status: "In Progress"
          )

          visit "/applications/#{application.id}"
          fill_in "pet_name", with: "zoey"

          click_button "Find Pets"

          expect(current_path).to eq("/applications/#{application.id}")
          expect(page).to have_content(pet_2.name)
        end
      end
    end
  end
end
