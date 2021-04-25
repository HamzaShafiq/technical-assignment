require 'rails_helper'

describe CsvController, type: :controller do

  describe 'GET #index' do
    
    it 'renders index page' do
      get :index
      expect(response.status).to be 200
    end
  end


  describe 'POST #import' do
    let(:header) { "Name,Nationality,Email,Model,Year,Chassis Number,Color,Registration Date,Odometer Reading" }
    let(:row2) { "Gemma,Kirke,gemma@kirke.me,Ford Focus,2018,123456789,Black,02/02/2018,30000" }
    let(:row3) { "Jane Thomas,Australia,jane@thomas.me,AudiA4,2020,999999999,Green,02/02/2019,25000" }
    let(:row4) { "Gemma,Kirke,gemma@kirke.me,INFINITI JX35,2011,444444444,Black,02/01/2019,12000" }

    let!(:rows) { [header, row2, row3, row4] }

    let!(:file_path) { "tmp/test_upload.csv" }

    let!(:csv) do
      CSV.open(file_path, "w") do |csv|
        rows.each do |row|
          csv << row.split(",")
        end
      end
    end

    let!(:file) { Rack::Test::UploadedFile.new 'tmp/test_upload.csv', 'text/csv' }

    it 'uploads a csv file' do
      post :import, params: { file: file }
      expect(Customer.all.size).to eq(2)
      expect(Vehicle.all.size).to eq(3)
    end
  end

  describe 'GET #search_vehicles' do
    context 'renders no search results' do
      it 'check search results should not be present' do
        get :search_vehicles, xhr: true, params: {search: 'AAAA'}
        expect(assigns(:searched_data)).to be_empty
      end
    end

    context 'renders search results' do
      let!(:customer1) { create(:customer) }
      let!(:customer2) { create(:customer, name: 'Test') }
      let!(:vehicle1) { create(:vehicle, customer_id: customer1.id) }
      let!(:vehicle2) { create(:vehicle, chassis_number: 11111111, customer_id: customer2.id) }

      it 'check search results should be present' do
        get :search_vehicles, xhr: true, params: {search: 'Hamza'}
        expect(assigns(:searched_data)).to be_present
      end
    end
  end

  describe 'POST #generate_customers_report_by_nationality' do
    let!(:customer1) { create(:customer) }
    let!(:customer2) { create(:customer, name: 'Test') }
    let!(:vehicle1) { create(:vehicle, customer_id: customer1.id) }
    let!(:vehicle2) { create(:vehicle, chassis_number: 11111111, customer_id: customer2.id) }

    it 'Csv file should be downloaded' do
      post :generate_customers_report_by_nationality, format: :csv
      expect(response.headers['Content-Type']).to have_content 'text/csv' 
    end
  end
end
