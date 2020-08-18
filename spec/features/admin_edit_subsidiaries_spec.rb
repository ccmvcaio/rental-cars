require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'attributes cant be blank' do
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '01.012.123/0001-00',
                       address: 'Av. Jabaquara, 245')

    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - São Paulo'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  scenario 'subsidiary must be unique' do
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '01.012.123/0001-00',
                       address: 'Av. Jabaquara, 245')
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '00.000.021/0001-11',
                       address: 'Praça da Moça, 43')

    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    click_on 'Editar'
    fill_in 'Nome', with: 'Rental Cars - São Paulo'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
  
  scenario 'successfully' do
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '01.012.123/0001-00',
                       address: 'Av. Jabaquara, 245')

  visit root_path
  click_on 'Filiais'
  click_on 'Rental Cars - São Paulo'
  click_on 'Editar'
  fill_in 'Nome', with: 'Rental Cars - Diadema'
  fill_in 'CNPJ', with: '00.000.000/0001-22'
  fill_in 'Endereço', with: 'Praça da Moça, 22'
  click_on 'Enviar'

  expect(page).to have_content('Rental Cars - Diadema')
  expect(page).not_to have_content('Rental Cars - São Paulo')
  expect(page).to have_content('00.000.000/0001-22')
  expect(page).not_to have_content('01.012.123/0001-00')
  expect(page).to have_content('Praça da Moça, 22')
  expect(page).not_to have_content('Av. Jabaquara, 245')
  end

end