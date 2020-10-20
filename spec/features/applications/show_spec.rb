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
        application: application,
        pet_application_status: "Pending"
      )
      PetApplication.create(
        pet: pet_2,
        application: application,
        pet_application_status: "Pending"
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

          within '#add-pets' do
            expect(page).to have_content(pet_2.name)
          end
        end
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit an application's show page and I search for a Pet by name" do
    describe "And I click on an 'Adopt this Pet' button next to a pet's name" do
      it "Then I am taken back to the application show page and I see the Pet I want to adopt listed on this application" do
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

        fill_in "pet_name", with: "cosmo"

        click_button "Find Pets"
        click_button "Adopt this Pet"

        expect(current_path).to eq("/applications/#{application.id}")

        within '#added-pets' do
          expect(page).to have_link("Cosmo")

          click_link "Cosmo"

          expect(current_path).to eq("/pets/#{pet_1.id}")
        end
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit an application's show page and I have added one or more pets to the application" do
    describe "Then I see a section to submit my application where I can input a description" do
      describe "When I fill in that input and I click a button to submit this application" do
        it "Then I am taken back to the application's show page, I see that the application is 'Pending', I see all the pets that I want to adopt, and I do not see a section to add more pets to this application" do
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

          visit "/applications/#{application.id}"

          within '#apply' do
            fill_in "Description", with: "I am more awesome"

            click_button "Submit Application"
          end

          expect(current_path).to eq("/applications/#{application.id}")

          expect(page).to have_content("Pending")
          expect(page).to have_link(pet_1.name)
          expect(page).to have_link(pet_2.name)
          expect(page).to have_no_content("Add a Pet to this Application")
        end
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit an application's show page" do
    describe "And I have not added any pets to the application" do
      it "Then I do not see a section to submit my application" do
        user = User.create!(
          name: "Jake",
          address: "222 1st St.",
          city: "Denver",
          state: "CO",
          zip: "80202"
        )
        application = Application.create(
          user: user,
          status: "In Progress"
        )

        visit "/applications/#{application.id}"

        expect(page).to have_no_content("Submit Application")
      end
    end
  end
end

describe "As a visitor" do
  describe "When I visit an application's show page" do
    describe "And I have added one or more pets to the application, but fail to enter description" do
      it "Then I am taken back to the application's show page and I see a flash message to fill out that field before I can submit the application and I see my application is still 'In Progress'" do
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

        visit "/applications/#{application.id}"

        click_button "Submit Application"

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content("You must fill out a description to complete a submission.")
        expect(page).to have_content("In Progress")
      end
    end
  end
end

describe "As a visitor" do
  describe "When visit an application show page" do
    describe "And I search for Pets by name" do
      it "Then I see any pet whose name PARTIALLY matches my search and casing doesn't matter" do
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
          name: "Cosmopolis",
          age: "9",
          sex: "Female",
          status: "Adoptable",
          shelter: shelter
        )
        application = Application.create(
          user: user,
          status: "In Progress"
        )

        visit "/applications/#{application.id}"

        fill_in "pet_name", with: "osmo"

        click_button "Find Pets"

        expect(page).to have_content("Cosmo")
        expect(page).to have_content("Cosmopolis")

        fill_in "pet_name", with: "cOS"

        click_button "Find Pets"

        expect(page).to have_content("Cosmo")
        expect(page).to have_content("Cosmopolis")

        fill_in "pet_name", with: "mop"

        click_button "Find Pets"

        expect(page).to have_content("Cosmopolis")

        fill_in "pet_name", with: "zoey"

        click_button "Find Pets"

        expect(page).to have_no_content("Zoey")
        expect(page).to have_no_content("Cosmo")

      end
    end
  end
end

describe "As a visitor" do
  describe "When I've created an application and am choosing pets" do
    it "Once I add a pet, that pet will not appear in another Find Pets search" do
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
        status: "In Progress"
      )

      visit "/applications/#{application.id}"

      fill_in "pet_name", with: "Cosmo"

      click_button "Find Pets"

      within "#pet-#{pet_1.id}" do
        click_button "Adopt this Pet"
      end

      fill_in "pet_name", with: "Cosmo"

      click_button "Find Pets"

      within "#pet-#{pet_1.id}" do
        expect(page).to have_no_content("Cosmo")
      end
    end
  end
end
