require "test_helper"

class VehicleTest < ActiveSupport::TestCase

  describe "Associations" do
    it { should have_many(:vehicles) }
  end
end
