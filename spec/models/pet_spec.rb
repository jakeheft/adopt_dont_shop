require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it { should validate_presence_of :image }
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :sex }
  end
  describe "relationships" do
    it { should belong_to :shelter }
    it { should have_many :applications }
    it { should have_many(:users).through(:applications) }
  end
end
