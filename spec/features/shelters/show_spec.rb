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

# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter
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
