describe "As a visitor" do
  describe "On the new shelter review page" do
    it "I see a form where I must enter info" do
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211"
      )
      user = User.create!(
        name: "Jake",
        address: "222 1st St.",
        city: "Denver",
        state: "CO",
        zip: "80202"
      )

      visit "/shelters/#{shelter_1.id}/reviews/new"

      fill_in "Title", with: "Good review"
      fill_in "Rating", with: "5"
      fill_in "Content", with: "It was good"
      fill_in "Image", with: "https://images.unsplash.com/photo-1601758124510-52d02ddb7cbd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1088&q=80"
      fill_in "User", with: user.name

      click_button "Create Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Good review")
      expect(page).to have_content("Jake")
      expect(page).to have_content("5")
      expect(page).to have_content("It was good")
      expect(page).to have_xpath("//img[contains(@src, '#{review_1.image}')]")

    end
  end
end
- title
- rating
- content
- the name of a user that exists in the database
I also see a field where I can enter an optional image (web address)
When the form is submitted, I should return to that shelter's show page
and I can see my new review
