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

describe "As a visitor" do
  describe "When I visit an admin application show page" do
    describe "For every pet in the application, I see a button to reject the application for that pet" do
      it "When I click the button I go to admin application show and I see an 'Rejected' indicator instead of a button" do
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
          click_button("Reject Pet")

          expect(current_path).to eq("/admin/applications/#{application.id}")

          expect(page).to have_no_button("Reject Pet")
          expect(page).to have_no_button("Accept Pet")
          expect(page).to have_content("Rejected")
        end

        within "#pet-#{pet_2.id}" do
          click_button("Reject Pet")

          expect(current_path).to eq("/admin/applications/#{application.id}")

          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_no_button("Reject Pet")
          expect(page).to have_content("Rejected")
        end
      end
    end
  end
end

describe "As a visitor" do
  describe  "When I visit an admin application show page" do
    describe "And I approve all pets for an application" do
      it "I go back to the admin application show page to see application's status is'Approved'" do
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
          status: "Pending"
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


        within("#pet-#{pet_1.id}") do
          click_button "Approve Pet"
        end
        within("#pet-#{pet_2.id}") do
          click_button "Approve Pet"
        end

        expect(page).to have_content("Application status: Approved")
      end
    end
  end
end

describe "As a visitor" do
  describe "When a pet has an 'Approved' application on them my application for that pet has a 'Pending' application on them" do
    describe "When I visit the admin application show page" do
      it "Then next to the pet I do not see response buttons but rather a pet approved message" do
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
        pet_2 = Pet.create(
          image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
          name: "Zoey",
          age: "9",
          sex: "Female",
          status: "Adoptable",
          shelter: shelter
        )
        application_1 = Application.create(
          user: user_1,
          description: "I am awesome",
          status: "Approved"
        )
        application_2 = Application.create(
          user: user_2,
          description: "I am more awesome",
          status: "Pending"
        )
        PetApplication.create(
          pet: pet_1,
          application: application_1,
          pet_application_status: "Approved"
        )
        PetApplication.create(
          pet: pet_1,
          application: application_2,
          pet_application_status: "Pending"
        )
        PetApplication.create(
          pet: pet_2,
          application: application_2,
          pet_application_status: "Pending"
        )

        visit "/admin/applications/#{application_2.id}"

        within "#pet-#{pet_1.id}" do
          expect(page).to have_no_button("Approve Pet")
          expect(page).to have_no_button("Reject Pet")
          expect(page).to have_content("Already approved in another application")
        end
        within "#pet-#{pet_2.id}" do
          expect(page).to have_button("Approve Pet")
          expect(page).to have_button("Reject Pet")
          expect(page).to have_no_content("Already approved in another application")
        end
      end
    end
  end
end
