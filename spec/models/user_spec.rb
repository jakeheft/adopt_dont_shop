require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews}
    it { should have_many(:shelters).through(:reviews) }
    it { should have_many :applications }
    # it { should have_many(:pet_applications).through(:applications) }
  end
end
