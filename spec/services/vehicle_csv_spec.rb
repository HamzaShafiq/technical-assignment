require 'rails_helper'

RSpec.describe VehicleCsv, type: :service do
  let!(:customer1) { create(:customer) }
  let!(:customer2) { create(:customer, name: 'Test') }
  let!(:vehicle1) { create(:vehicle, customer_id: customer1.id) }
  let!(:vehicle2) { create(:vehicle, chassis_number: 11111111, customer_id: customer2.id) }

  let(:subject) { described_class.new }

  it "Check 2 vehicle records should be present when service is initialized" do
    expect(subject.vehicles_data.size).to eq(2)
  end

  context "Check correct records returned by searched_data" do 
    it "when search for customer name" do
      expect(subject.searched_data('Test').size).to eq(1)
    end

    it "when search for vehicle model" do
      expect(subject.searched_data('Ford').size).to eq(2)
    end
  end

end
