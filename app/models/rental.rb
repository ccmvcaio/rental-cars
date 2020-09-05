class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :car_category
  has_one :car_rental
  

  validates :start_date, :end_date, :client, :car_category, presence: true

  before_create :generate_token

  private
  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end
end
