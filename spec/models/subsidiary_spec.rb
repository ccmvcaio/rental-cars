require 'rails_helper'

describe Subsidiary, type: :model do
  context 'validation' do
    it 'attributes cannot be blank'do
      subsidiary = Subsidiary.new

      subsidiary.valid?

      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
      expect(subsidiary.errors[:address]).to include('não pode ficar em branco')
    end

    it 'CNPJ must be unique' do
      Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                         address: 'Av. Sumaré, 987')
      subsidiary = Subsidiary.new(cnpj: '14.566.342/0001-88')

      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('já está em uso')
    end

    it 'CNPJ must be valid' do
      subsidiary = Subsidiary.new(name: 'Rental Cars - São Paulo', 
                                  cnpj: '14.566.342/0000-00', address: 'Av Paulista, 989')
      
      subsidiary.valid?

      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end

  end
end
