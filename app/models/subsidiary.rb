class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :name, uniqueness: {case_sensitive: false}
end
