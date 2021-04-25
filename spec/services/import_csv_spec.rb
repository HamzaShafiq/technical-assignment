require 'rails_helper'

RSpec.describe ImportCsv, type: :service do
  let(:header) { "Name,Nationality,Email,Model,Year,Chassis Number,Color,Registration Date,Odometer Reading" }
  let(:row2) { "Gemma,Kirke,gemma@kirke.me,Ford Focus,2018,123456789,Black,02/02/2018,30000" }
  let(:row3) { "Jane Thomas,Australia,jane@thomas.me,AudiA4,2020,999999999,Green,02/02/2019,25000" }
  let(:row4) { "Gemma,Kirke,gemma@kirke.me,INFINITI JX35,2011,444444444,Black,02/01/2019,12000" }

  let(:rows) { [header, row2, row3, row4] }

  let(:file_path) { "tmp/test.csv" }

  let!(:csv) do
    CSV.open(file_path, "w") do |csv|
      rows.each do |row|
        csv << row.split(",")
      end
    end
  end

  let(:csv_file) { File.open("tmp/test.csv") }

  let(:subject) { ImportCsv.new(csv_file) }

  after(:each) { File.delete(csv_file) }

  it "No records should be present before uploading csv" do
    expect(Customer.all.size).to eq(0)
    expect(Vehicle.all.size).to eq(0)
  end

  it "Valid no of customer records should be created as per csv" do
    subject.call
    expect(Customer.all.size).to eq(2)
    expect(subject.error).to be_empty
  end

  it "Valid no of vehicle records should be created as per csv" do
    subject.call
    expect(Vehicle.all.size).to eq(3)
    expect(subject.error).to be_empty
  end

end
