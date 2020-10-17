require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews}
    it { should have_many(:shelters).through(:reviews) }
    it { should have_many :applications }
    # it { should have_many(:pet_applications).through(:applications) }
  end
end

describe "instance methods" do
  it "#full_address" do
    user = User.create!(
      name: "Jake",
      address: "222 1st St.",
      city: "Denver",
      state: "CO",
      zip: "80202"
    )
    application = Application.create(
      user: user,
      description: "I am awesome",
      status: "In Progress"
    )

    expect(user.full_address).to eq("222 1st St., Denver, CO, 80202")
  end
end
