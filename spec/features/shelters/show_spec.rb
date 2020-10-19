require 'rails_helper'

describe "When I visit '/shelters/:id'" do
  it "I see the shelter with that id and its info" do
    shelter_1 = Shelter.create(
      name: "Denver Shelter",
      address: "123 Main St.",
      city: "Denver",
      state: "CO",
      zip: "80211"
    )

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_1.address}")
    expect(page).to have_content("#{shelter_1.city}")
    expect(page).to have_content("#{shelter_1.state}")
    expect(page).to have_content("#{shelter_1.zip}")
  end
end

describe "When I visit a shelter show page I see a link to delete the shelter" do
  it "When I click the link I'm redirected to '/shelters' where the shelter is gone" do
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

    visit "/shelters/#{shelter_2.id}"

    click_button

    expect(current_path).to eq("/shelters")
    expect(page).to have_no_content("Happy Animals")
    expect(page).to have_content("Denver Shelter")
  end
end

describe "As a visitor," do
  describe "When I visit a shelter's show page," do
    it "I see a list of reviews for that shelter containing review components" do
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      user = User.create(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
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

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content("Good Review")
      expect(page).to have_content(5)
      expect(page).to have_content("It was good")
      expect(page).to have_xpath("//img[contains(@src, '#{review_1.image}')]")
      expect(page).to have_content("Jake")
      expect(page).to have_content("Bad Review")
      expect(page).to have_content(1)
      expect(page).to have_content("It was bad")
      expect(page).to have_content("Jake")

    end
  end
end

describe "As a visitor," do
  describe "When I visit a shelter's show page" do
    describe "I see a link to add a new review for this shelter" do
      it "When I click on this link, I am taken to a new review path" do
        shelter_1 = Shelter.create(
          name: "Denver Shelter",
          address: "123 Main St.",
          city: "Denver",
          state: "CO",
          zip: "80211"
        )

        visit "/shelters/#{shelter_1.id}"

        click_link('Add Review')

        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
      end
    end
  end
end

describe "As a visitor," do
  describe "When I visit a shelter's show page, I see a link to delete each shelter" do
    it "When I click this link I am returned to the shelter show page And I don't see that shelter review" do
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      user = User.create(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )
      review_1 = Review.create(
        title: "So good",
        rating: 5,
        content: "It's so good",
        user: user,
        shelter: shelter_1
      )

      visit "/shelters/#{shelter_1.id}"

      click_link "Delete Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_no_content("So good")
      expect(page).to have_no_content(5)
      expect(page).to have_no_content("It's so good")
      expect(page).to have_no_content("Jake")
    end
  end
end

describe "When I visit a shelter's show page" do
  it "I see statistics for count of pets at the shelter, average shelter review rating and number of applications on file" do
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
    application_1 = Application.create(
      user: user_1,
      status: "In Progress"
    )
    application_2 = Application.create(
      user: user_2,
      status: "In Progress"
    )
    application_3 = Application.create(
      user: user_3,
      status: "In Progress"
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

    visit "/shelters/#{shelter.id}"

    expect(page).to have_content("We have #{shelter.total_pets} right now!")
    expect(page).to have_content("Average Review Rating: 4.67")
    expect(page).to have_content("#{shelter.total_applications} Applications Currently on File")
  end
end
