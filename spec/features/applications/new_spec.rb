require 'rails_helper'

describe "As a visitor," do
  describe "When I visit '/applications/new'" do
    describe "And I fill out and submit the form" do
      it "Then I am taken to the new application's show page where I see my user, all address info and an indicator that the application is 'In Progress'" do
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
        user = User.create(
          name: "Jake",
          address: "222 1st St.",
          city: "Denver",
          state: "CO",
          zip: "80202"
        )

        visit 'applications/new'

        fill_in "user_name", with: user.name

        click_button 'Create Application'

        application = Application.last

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content(user.name)
        expect(page).to have_content(user.full_address)
        expect(page).to have_content('In Progress')
      end
    end
  end
end
