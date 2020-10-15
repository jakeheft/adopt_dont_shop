require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many :reviews}
    it { should have_many(:shelters).through(:reviews) }
  end
end
