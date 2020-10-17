require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "validations" do
    it { should validate_presence_of :application_id }
    it { should validate_presence_of :pet_id }
  end

  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end
end
