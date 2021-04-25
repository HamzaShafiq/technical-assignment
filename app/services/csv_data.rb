class CsvData

  attr_reader :vehicles_data

  def initialize
    @vehicles_data = Vehicle.includes(:customer)
  end

end
