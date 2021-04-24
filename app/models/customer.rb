class Customer < ApplicationRecord
  has_many :vehicles, dependent: :destroy
end
