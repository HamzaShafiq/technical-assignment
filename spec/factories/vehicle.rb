FactoryBot.define do
  factory :vehicle do
    model { "Ford" }
    year { 2018 }
    chassis_number { 123456789 }
    color { "Black" }
    registration_date { "2018-02-02" }
    odometer_reading { 30000 }
  end
end