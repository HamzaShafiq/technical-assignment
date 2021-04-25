require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { create(:customer) }
  let(:invalid_customer) { described_class.new }
  let!(:valid_vehicle) { create(:vehicle, customer_id: customer.id) }


  context 'Check associations' do
    it { should have_many(:vehicles) }
  end

  context 'Check Model records' do 
    it "Invalid record should not be created" do
      expect(invalid_customer.valid?).to be_falsey
    end

    it "Valid record should be created" do
      expect(customer.valid?).to be_truthy
    end

    it "Should have 1 vehicle record" do
      expect(customer.vehicles.count).to eq(1)
    end

    it "Should have 0 vehicle record" do
      customer.destroy
      expect(customer.vehicles.count).to eq(0)
    end
  end

  
end
