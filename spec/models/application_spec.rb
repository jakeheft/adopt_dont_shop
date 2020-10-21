require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :status }
    # it { should validate_presence_of :pet_id }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "instance methods" do
    it "#status_check" do
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
    pet_3 = Pet.create(
      image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
      name: "Mosmo",
      age: "8",
      sex: "Male",
      status: "Adoptable",
      shelter: shelter
    )
    pet_4 = Pet.create(
      image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
      name: "Moey",
      age: "9",
      sex: "Female",
      status: "Adoptable",
      shelter: shelter
    )
    pet_5 = Pet.create(
      image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
      name: "Moey",
      age: "9",
      sex: "Female",
      status: "Adoptable",
      shelter: shelter
    )
    application_1 = Application.create(
      user: user,
      description: "I am awesome",
      status: "Pending"
    )
    application_2 = Application.create(
      user: user,
      description: "I am more awesome",
      status: "Pending"
    )
    application_3 = Application.create(
      user: user,
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
      application: application_1,
      pet_application_status: "Approved"
    )
    PetApplication.create(
      pet: pet_3,
      application: application_2,
      pet_application_status: "Approved"
    )
    PetApplication.create(
      pet: pet_4,
      application: application_2,
      pet_application_status: "Rejected"
    )
    PetApplication.create(
      pet: pet_5,
      application: application_3,
      pet_application_status: "Pending"
    )

    expect(application_1.status_check).to eq("Approved")
    expect(application_1.status).to eq("Approved")
    expect(application_2.status_check).to eq("Rejected")
    expect(application_2.status).to eq("Rejected")
    expect(application_3.status_check).to eq("Pending")
    expect(application_3.status).to eq("Pending")
    end
  end
end
