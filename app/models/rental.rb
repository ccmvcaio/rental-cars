class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :car_category
  validates :start_date, :end_date, :client, :car_category, presence: true
end
