class Vehicle < ApplicationRecord
  belongs_to :customer

  scope :searched_vehicles, -> (search_term) { joins(:customer).where('vehicles.model LIKE ? or customers.name LIKE ?', "%#{search_term}%", "%#{search_term}%") }
end
