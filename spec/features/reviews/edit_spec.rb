require "rails_helper"

describe "As a visitor," do
  describe "When I visit a shelter's show page" do
    describe "I see a link to edit the shelter review next to each review." do
      describe "When I click on this link, I am taken to an edit shelter review path and see populated form" do
        it "I update the fields and submit, then I'm redirected to shelter show page where I can see my review." do
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

          visit "/shelters/#{shelter_1.id}"

          click_link "Edit Review"
          expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")

          fill_in "title", with: "So very good"

          expect(find_field('Title').value).to eq("So very good")
          expect(find_field('Rating').value).to eq("5")
          expect(find_field('Content').value).to eq("It's so good")

          click_button "Update Review"

          expect(current_path).to eq("/shelters/#{shelter_1.id}")
          expect(page).to have_content("So very good")
          expect(page).to have_content("It's so good")
        end
      end
    end
  end
end

describe "As a visitor," do
  describe "When I visit the page to edit a review and I fail to enter a field and submit" do
    it "I see a flash message indicating that I need to fill in info in order to submit review And I'm returned to the edit form to edit that review" do
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

      visit "/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit"

      fill_in "Title", with: ""

      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit")
      expect(page).to have_content("All fields except for image must be filled out.")
    end
  end
end
