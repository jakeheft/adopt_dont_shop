require 'rails_helper'

describe "When I visit a shelter show page I see a link to update" do
  it "When I click the link 'Update Shelter' I'm taken to '/shelters/:id/edit' where I see a form to edit the shelter's data" do
    shelter = Shelter.create(
      name: "Denver Shelter",
      address: "123 Main St.",
      city: "Denver",
      state: "CO",
      zip: "80211")

    visit "shelters/#{shelter.id}"

    click_link
    expect(current_path).to eq("/shelters/#{shelter.id}/edit")
    fill_in "shelter[name]", with: "Denver Shelter South"
    expect(find_field('shelter[name]').value).to eq"Denver Shelter South"
    expect(find_field('shelter[address]').value).to eq"#{shelter.address}"
    expect(find_field('shelter[city]').value).to eq"#{shelter.city}"
    expect(find_field('shelter[state]').value).to eq"#{shelter.state}"
    expect(find_field('shelter[zip]').value).to eq"#{shelter.zip}"
  end

  it "When I fill out the form I click the button to submit and am redirected to the Shelter's Show page where I see the shelter's updated info" do
    shelter = Shelter.create(
      name: "Denver Shelter",
      address: "123 Main St.",
      city: "Denver",
      state: "CO",
      zip: "80211")

    visit "shelters/#{shelter.id}/edit"

    fill_in "shelter[name]", with: "Denver Shelter South"

    click_button

    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content("#{shelter.name}")
    expect(page).to have_content("Denver Shelter South")
    expect(page).to have_content("#{shelter.address}")
    expect(page).to have_content("#{shelter.city}")
    expect(page).to have_content("#{shelter.state}")
    expect(page).to have_content("#{shelter.zip}")
  end
end
