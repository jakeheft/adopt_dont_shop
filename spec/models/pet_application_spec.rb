require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "validations" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
    it { should validate_presence_of :pet_application_status }
  end

  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "class methods" do
    it '#retrieve_id' do
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
      user = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      application_1 = Application.create(
        user: user,
        description: "I am awesome",
        status: "In Progress"
      )
      application_2 = Application.create(
        user: user,
        description: "I am alright",
        status: "In Progress"
      )
      pet_app_1 = PetApplication.create(
        pet: pet_1,
        application: application_2,
        pet_application_status: "Pending"
      )
      pet_app_2 = PetApplication.create(
        pet: pet_2,
        application: application_2,
        pet_application_status: "Pending"
      )
      pet_app_3 = PetApplication.create(
        pet: pet_3,
        application: application_2,
        pet_application_status: "Pending"
      )
      pet_app_4 = PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Pending"
      )
      pet_app_5 = PetApplication.create(
        pet: pet_2,
        application: application_1,
        pet_application_status: "Pending"
      )
      pet_app_6 = PetApplication.create(
        pet: pet_3,
        application: application_1,
        pet_application_status: "Pending"
      )

      expect(PetApplication.retrieve(pet_1.id, application_1.id)).to eq (pet_app_4)
      expect(PetApplication.retrieve(pet_1.id, application_2.id)).to eq (pet_app_1)
      expect(PetApplication.retrieve(pet_2.id, application_1.id)).to eq (pet_app_5)
      expect(PetApplication.retrieve(pet_2.id, application_2.id)).to eq (pet_app_2)
      expect(PetApplication.retrieve(pet_3.id, application_1.id)).to eq (pet_app_6)
      expect(PetApplication.retrieve(pet_3.id, application_2.id)).to eq (pet_app_3)
    end
  end
end
