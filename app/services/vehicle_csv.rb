class VehicleCsv

  attr_reader :vehicles_data

  def initialize
    @vehicles_data = Vehicle.joins(:customer)
  end

  def searched_data(search)
    Vehicle.searched_vehicles(search)
  end

  def generate_customers_report
    report_data = Vehicle.customers_by_nationality(@vehicles_data)

    attributes = %w{nationality number_of_customers}

    CSV.generate(headers: true) do |csv|
      attributes << attributes
      report_data.each do |data|
        csv << data.attributes.values
      end
    end
  end

end
