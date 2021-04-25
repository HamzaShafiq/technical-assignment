class CsvController < ApplicationController
  before_action :validate_file, only: [:import]

  def index
    csv_service = CsvData.new
    @vehicles_data = csv_service.vehicles_data
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
    csv_service = CsvData.new
    @searched_data = csv_service.searched_data(params[:search])
    respond_to :js
  end


  private

  def validate_file
    redirect_to root_url, alert: "File not uploaded" if params[:file].blank?
  end
end
