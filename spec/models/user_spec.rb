require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews}
    it { should have_many(:shelters).through(:reviews) }
    it { should have_many :applications }
    it { should have_many(:pets).through(:applications) }
  end
end
