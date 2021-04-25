class ImportCsv

  CUSTOMER_KEYS = %w[name email nationality]
  VEHICLE_KEYS = %w[model year chassis_number color registration_date odometer_reading]

  attr_reader :error

  def initialize(file)
    @file = file
    @error = ''
    @header_converters = lambda { |h| h.to_s.downcase.gsub(' ', '_') }
  end

  def call
    vehicles = []

    begin
      CSV.foreach(@file.path, headers: true, :header_converters => @header_converters) do |row|
        customer = create_customer(row)
        vehicles << initialize_vehicle(row, customer.id)
  	  end
      # Insert all gives error if created_at/updated_at is null
      # Ref: https://github.com/rails/rails/pull/35635#issuecomment-478360317
      # Vehicle.where(created_at: Time.now).insert_all!(vehicles.as_json)
      # That's why using active_record import gem
      # Making an assumption here that chasis number would be unique.
      Vehicle.import vehicles
  	rescue Exception => e
  	  @error = e.full_message
  	end
  end


  private

  	def create_customer(row)
  	  customer_hash = row.to_h.slice(*CUSTOMER_KEYS) 
	    Customer.find_or_create_by(customer_hash)
  	end

  	def initialize_vehicle(row, customer_id)
  	  vehicle_hash = row.to_h.slice(*VEHICLE_KEYS) 

  	  vehicle = Vehicle.new(vehicle_hash)
  	  vehicle.customer_id = customer_id

  	  vehicle
  	end

end
