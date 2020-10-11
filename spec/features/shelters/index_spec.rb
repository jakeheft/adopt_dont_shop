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

describe "As a visitor" do
  describe "When I visit the shelter index page I see an edit link next to each shelter" do
    it "When I click the link, I'm taken to edit the shelter" do
      shelter = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211")

      visit "/shelters"

      click_link "Edit Shelter"

      expect(current_path).to eq("/shelters/#{shelter.id}/edit")
    end
  end
end

describe "As a visitor" do
  describe "When I visit the shelter index page I see a delete link next to each shelter" do
    it "When I click the link I'm returned to '/shelter' and that shelter is gone" do
      shelter_1 = Shelter.create(
        name: "Denver Shelter",
        address: "123 Main St.",
        city: "Denver",
        state: "CO",
        zip: "80211")
      shelter_2 = Shelter.create(
        name: "Happy Animals",
        address: "888 2nd Ave.",
        city: "CO Springs",
        state: "CO",
        zip: "80333")

      visit "shelters/"

      click_link("Delete Shelter", match: :first)

      expect(current_path).to eq ("/shelters")
      expect(page).to have_no_content("Denver Shelter")
      expect(page).to have_content("Happy Animals")
    end
  end
end
