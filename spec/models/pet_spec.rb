require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
  end
  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :pet_applications}
    it { should have_many(:applications).through(:pet_applications) }
    # it { should have_many(:users).through(:applications) }
  end

  describe 'instance methods' do
    it '#status_anywhere?' do
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
        pet: pet_2,
        application: application_2,
        pet_application_status: "Pending"
      )

      expect(pet_1.status_anywhere?("Approved")).to eq(true)
      expect(pet_2.status_anywhere?("Approved")).to eq(false)
      expect(pet_1.status_anywhere?("Pending")).to eq(false)
      expect(pet_2.status_anywhere?("Pending")).to eq(true)
      expect(pet_1.status_anywhere?("Rejected")).to eq(false)
      expect(pet_2.status_anywhere?("Rejected")).to eq(false)

    end
  end

  describe "class methods" do
    it '#find_pets' do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      pet_1 = Pet.create(
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "cosmo",
        age: "8",
        sex: "Male",
        status: "Adoptable",
        shelter: shelter
      )
      pet_2 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "zoey",
        age: "9",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter
      )
      pet_3 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "zoey",
        age: "4",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter
      )
      expect(Pet.find_pets("zoey")).to eq([pet_2, pet_3])
    end

    it "#application_needed?" do
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
      PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Rejected"
      )
      PetApplication.create(
        pet: pet_2,
        application: application_2,
        pet_application_status: "Approved"
      )

      expect(pet_1.application_needed?).to eq(false)
      expect(pet_2.application_needed?).to eq(true)
    end

    it "#destroy_pet_apps" do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      pet = Pet.create(
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "Cosmo",
        age: "8",
        sex: "Male",
        status: "Adoptable",
        shelter: shelter
      )
      user = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      application = Application.create(
        user: user,
        status: "Rejected"
      )
      pet_app = PetApplication.create(
        pet: pet,
        application: application,
        pet_application_status: "Rejected"
      )

      pet.destroy_pet_apps
      expect(PetApplication.where(id: pet_app.id)).to eq([])
    end
  end
end
