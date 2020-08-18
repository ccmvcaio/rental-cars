require 'rails_helper'

  feature 'admin register valid subsidiary' do
    scenario 'and attributes must not be blank' do
      visit root_path
      click_on 'Filiais'
      click_on 'Registrar uma nova filial'
      fill_in 'Nome', with: ''
      fill_in 'CNPJ', with: ''
      fill_in 'Endereço', with: ''
      click_on 'Enviar'

      expect(page).to have_content('não pode ficar em branco', count: 3)
    end

    scenario 'and subsidiary must be unique' do
      Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                         address: 'Av. Jabaquara, 453')
      
      visit root_path
      click_on 'Filiais'
      click_on 'Registrar uma nova filial'
      fill_in 'Nome', with: 'Rental Cars - São Paulo'
      fill_in 'CNPJ', with: '14.566.342/0001-88'
      fill_in 'Endereço', with: 'Av. Boa vista, 900'
      click_on 'Enviar'

      expect(page).to have_content('já está em uso')
    end
  end