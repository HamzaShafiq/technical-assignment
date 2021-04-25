class CsvController < ApplicationController
  before_action :validate_file, only: [:import]
  before_action :initialize_vehicle_csv_service, only: [:index, :search_vehicles, :generate_customers_report_by_nationality]

  def index
    @vehicles_data = @vehicle_csv_service.vehicles_data
  end

  def import
  	import_csv_service = ImportCsv.new(params[:file])
  	import_csv_service.call

  	if import_csv_service.error.present?
      redirect_to root_url, alert: "CSV data not imported successfully"
  	else
      redirect_to root_url, notice: "CSV data imported successfully"
  	end
  end

  def search_vehicles
    @searched_data = @vehicle_csv_service.searched_data(params[:search])
    respond_to :js
  end

  def generate_customers_report_by_nationality
    respond_to do |format|
      format.csv { send_data @vehicle_csv_service.generate_customers_report, filename: "customer-report-#{Time.now.to_i}.csv" }
    end
  end


  private

  def validate_file
    redirect_to root_url, alert: "File not uploaded" if params[:file].blank?
  end

  def initialize_vehicle_csv_service
    @vehicle_csv_service = VehicleCsv.new
  end
end
