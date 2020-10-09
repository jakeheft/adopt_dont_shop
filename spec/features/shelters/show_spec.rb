require 'rails_helper'

# When I visit '/shelters/:id'
# Then I see the shelter with that id including the shelter's:
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
