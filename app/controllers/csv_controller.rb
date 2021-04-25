class CsvController < ApplicationController
  before_action :validate_file, only: [:import]

  def index
  end

  def import
  	import_csv_service = ImportCsv.new(params[:file])

  	import_csv_service.call

  	if import_csv_service.error.present?
      puts "*" * 100
      puts "#{import_csv_service.error}"
      puts "*" * 100
      redirect_to root_url, alert: "CSV data not imported successfully"
  	else
      redirect_to root_url, notice: "CSV data imported successfully"
  	end
  end


  private

  def validate_file
    redirect_to root_url, alert: "File not uploaded" if params[:file].blank?
  end
end
