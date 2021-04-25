Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "csv#index"
  post '/import_csv', to: 'csv#import', as: :import_csv
  get '/search', to: 'csv#search_vehicles'
  post '/generate_customers_report', to: 'csv#generate_customers_report_by_nationality', defaults: { format: 'csv' }
end
