require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe "relationships" do
    it { should have_many :pets }
    it { should have_many :reviews }
    it { should have_many(:users).through(:reviews) }
  end

  describe "instance methods" do
    it '#total_pets' do
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
        name: "Ella",
        age: "8",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter
      )

      expect(shelter.total_pets).to eq(3)
    end

    it '#average_reviews' do
      user_1 = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      user_2 = User.create!(
        name: "Joke",
        address: "223 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      user_3 = User.create!(
        name: "Jerk",
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
      review_1 = Review.create(
        title: "So good",
        rating: 5,
        content: "It's so good",
        user: user_1,
        shelter: shelter
      )
      review_2 = Review.create(
        title: "Very good",
        rating: 5,
        content: "It's very good",
        user: user_2,
        shelter: shelter
      )
      review_3 = Review.create(
        title: "Good",
        rating: 4,
        content: "It's good",
        user: user_3,
        shelter: shelter
      )

      expect(shelter.average_reviews.round(4)).to eq(4.6667)
    end

    it '#total_applications' do
      user_1 = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      user_2 = User.create!(
        name: "Joke",
        address: "223 1st St.",
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
        status: "In Progress"
      )
      application_2 = Application.create(
        user: user_2,
        status: "Pending"
      )
      PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Pending"
      )
      PetApplication.create(
        pet: pet_2,
        application: application_2,
        pet_application_status: "Pending"
      )
      PetApplication.create(
        pet: pet_1,
        application: application_2,
        pet_application_status: "Pending"
      )

      expect(shelter.total_applications).to eq(2)
    end

    it "#needed_pets?" do
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
        shelter: shelter_1
      )
      pet_3 = Pet.create(
        image: "https://images.unsplash.com/photo-1455526050980-d3e7b9b789a4?ixlib=rb-1.2.1&auto=format&fit=crop&w=1525&q=80",
        name: "Mosmo",
        age: "8",
        sex: "Male",
        status: "Adoptable",
        shelter: shelter_2
      )
      pet_4 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "Moey",
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
        status: "Pending"
      )
      application_2 = Application.create(
        user: user,
        status: "Rejected"
      )
      PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Pending"
      )
      PetApplication.create(
        pet: pet_2,
        application: application_1,
        pet_application_status: "Approved"
      )
      PetApplication.create(
        pet: pet_3,
        application: application_2,
        pet_application_status: "Rejected"
      )
      PetApplication.create(
        pet: pet_4,
        application: application_2,
        pet_application_status: "In Progress"
      )

      expect(shelter_1.needed_pets?).to eq(true)
      expect(shelter_2.needed_pets?).to eq(false)
    end

    it "#destroy_associated_objects" do
      shelter_1 = Shelter.create(
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
        shelter: shelter_1
      )
      pet_2 = Pet.create(
        image: "https://images.unsplash.com/photo-1534361960057-19889db9621e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        name: "Zoey",
        age: "9",
        sex: "Female",
        status: "Adoptable",
        shelter: shelter_1
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
      pet_app_1 = PetApplication.create(
        pet: pet_1,
        application: application_1,
        pet_application_status: "Rejected"
      )
      pet_app_2 = PetApplication.create(
        pet: pet_2,
        application: application_1,
        pet_application_status: "Rejected"
      )
      review_1 = Review.create!(
        title: "Good Review",
        rating: 5,
        content: "It was good",
        image: "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1088&q=80",
        user: user,
        shelter: shelter_1
      )
      review_2 = Review.create!(
        title: "Bad Review",
        rating: 1,
        content: "It was bad",
        user: user,
        shelter: shelter_1
      )

      shelter_1.destroy_associated_objects

      expect(Pet.where(id: pet_1.id)).to eq([])
      expect(Pet.where(id: pet_2.id)).to eq([])
      expect(PetApplication.where(id: pet_app_1.id)).to eq([])
      expect(PetApplication.where(id: pet_app_2.id)).to eq([])
      expect(Review.where(id: review_1.id)).to eq([])
      expect(Review.where(id: review_2.id)).to eq([])
    end
  end
end
