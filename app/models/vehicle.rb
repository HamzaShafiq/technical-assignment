class Vehicle < ApplicationRecord
  belongs_to :customer

  scope :searched_vehicles, -> (search_term) { joins(:customer).where('vehicles.model LIKE ? or customers.name LIKE ?', "%#{search_term}%", "%#{search_term}%") }


  def self.customers_by_nationality(vehicles_data)
    vehicles_data.select("customers.nationality as nationality, count(*) as number_of_customers").group('customers.nationality')
  end
end
