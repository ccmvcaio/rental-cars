class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: true
  validates :name, :cnpj, :address, uniqueness: {case_sensitive: false}
  validate :cnpj_must_be_valid

  def cnpj_must_be_valid
    if cnpj.present? && !CNPJ.valid?(cnpj, strict: true)
      errors.add(:cnpj, 'não é válido')
    end
  end
end
