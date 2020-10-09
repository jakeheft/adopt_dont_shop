require 'rails_helper'

describe "When i visit '/shelters'" do
  it "Then I see the name of each shelter in the system" do
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

    visit "/shelters"

    expect(page).to have_content("#{shelter_1.name}")
    expect(page).to have_content("#{shelter_2.name}")
  end
end
