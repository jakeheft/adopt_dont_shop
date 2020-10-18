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
    it '#approved_anywhere?' do
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

      expect(pet_1.approved_anywhere?).to eq(true)
      expect(pet_2.approved_anywhere?).to eq(false)

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
      pet_3 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "Zoey",
        age: "4",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter
      )
      expect(Pet.find_pets("zoey")).to eq([pet_2, pet_3])
    end
  end
end
