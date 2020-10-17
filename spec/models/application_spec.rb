require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :description }
    it { should validate_presence_of :status }
    # it { should validate_presence_of :pet_id }
  end

  describe "relationships" do
    it { should belong_to :user }
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end
end
