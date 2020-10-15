require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I visit a User's show page" do
    it "Then I see all of that User's data" do
      user = User.create(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )

      visit "/users/#{user.id}"

      expect(page).to have_content("Jake")
      expect(page).to have_content("222 1st St.")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80202")
    end
  end
end

describe "As a visitor" do
  describe "When I visit a User's show page" do
    it "Then I see every review this User has written with all info" do
      user = User.create(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      shelter_2 = Shelter.create(
        name: "Happy Animals",
        address: "888 2nd Ave.",
        city: "CO Springs",
        state: "CO",
        zip: "80333"
      )
      review_1 = Review.create(
        title: "So good",
        rating: 5,
        content: "It's so good",
        user: user,
        shelter: shelter_1
      )
      review_2 = Review.create(
        title: "So bad",
        rating: 1,
        content: "It's so bad",
        image: "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1088&q=80",
        user: user,
        shelter: shelter_2
      )

      visit "/users/#{user.id}"

      expect(page).to have_content("#{review_1.title}")
      expect(page).to have_content("#{review_1.rating}")
      expect(page).to have_content("#{review_1.content}")
      expect(page).to have_content("#{review_2.title}")
      expect(page).to have_content("#{review_2.rating}")
      expect(page).to have_content("#{review_2.content}")
    end
  end
end

describe "As a visitor" do
  describe "When I visit a User's show page" do
    it "Then I see the average rating of all of their reviews" do
      user = User.create(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      shelter_1 = Shelter.create(
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
        user: user,
        shelter: shelter_1
      )
      review_2 = Review.create(
        title: "So bad",
        rating: 1,
        content: "It's so bad",
        image: "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1088&q=80",
        user: user,
        shelter: shelter_1
      )
      review_3 = Review.create(
        title: "So bad",
        rating: 1,
        content: "It's so bad",
        image: "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1088&q=80",
        user: user,
        shelter: shelter_1
      )

      visit "/users/#{user.id}"
      save_and_open_page
      expect(page).to have_content("Average review rating: 2.33")
    end
  end
end
