class CsvData

  attr_reader :vehicles_data

  def initialize
    @vehicles_data = Vehicle.includes(:customer)
  end

  def searched_data(search)
    Vehicle.searched_vehicles(search)
  end

end
