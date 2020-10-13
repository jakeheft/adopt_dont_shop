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
