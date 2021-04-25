require 'rails_helper'

RSpec.describe Vehicle, type: :model do

  let(:customer) { create(:customer) }
  let(:invalid_vehicle) { described_class.new }
  let(:valid_vehicle) { create(:vehicle, customer_id: customer.id) }


  context 'Check associations' do
    it { should belong_to(:customer) }
  end

  it "Invalid record should not be created" do
    expect(invalid_vehicle.valid?).to be_falsey
  end

  it "Valid record should be created" do
    expect(valid_vehicle.valid?).to be_truthy
  end
end
