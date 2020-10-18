require 'rails_helper'

describe "As a visitor" do
  describe "When I visit an admin application show page" do
    describe "For every pet in the application, I see a button to approve the application for that pet" do
      it "When I click the button I go to admin application show and I see an 'Approved' indicator instead of a button" do
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
          application: application,
          pet_application_status: "Pending"
        )
        PetApplication.create(
          pet: pet_2,
          application: application,
          pet_application_status: "Pending"
        )

        visit "/admin/applications/#{application.id}"
        within "#pet-#{pet_1.id}" do
          click_button("Approve Pet")

          expect(current_path).to eq("/admin/applications/#{application.id}")

          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_content("Approved")
        end

        within "#pet-#{pet_2.id}" do
          click_button("Approve Pet")

          expect(current_path).to eq("/admin/applications/#{application.id}")

          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_content("Approved")
        end
      end
    end
  end
end
