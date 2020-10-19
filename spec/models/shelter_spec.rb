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
  end
end
