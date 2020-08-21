require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'and must be signed in' do
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'attributes cant be blank' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                       address: 'Av. Jabaquara, 245')

    login_as(user, scope: :user)
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
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                       address: 'Av. Jabaquara, 245')
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '99.133.221/0001-03',
                       address: 'Praça da Moça, 43')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    click_on 'Editar'
    fill_in 'Nome', with: 'Rental Cars - São Paulo'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end
  
  scenario 'successfully' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                       address: 'Av. Jabaquara, 245')

  login_as(user, scope: :user)
  visit root_path
  click_on 'Filiais'
  click_on 'Rental Cars - São Paulo'
  click_on 'Editar'
  fill_in 'Nome', with: 'Rental Cars - Diadema'
  fill_in 'CNPJ', with: '99.133.221/0001-03'
  fill_in 'Endereço', with: 'Praça da Moça, 22'
  click_on 'Enviar'

  expect(page).to have_content('Rental Cars - Diadema')
  expect(page).not_to have_content('Rental Cars - São Paulo')
  expect(page).to have_content('99.133.221/0001-03')
  expect(page).not_to have_content('14.566.342/0001-88')
  expect(page).to have_content('Praça da Moça, 22')
  expect(page).not_to have_content('Av. Jabaquara, 245')
  end
end