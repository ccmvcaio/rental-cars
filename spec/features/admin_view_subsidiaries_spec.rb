require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'and must be signed in' do
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '99.133.221/0001-03', 
                       address: 'Rua dos Milionários, 1010')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                       address: 'Av. Jabaquara, 2068')
    Subsidiary.create!(name: 'Rental Cars - São Caetano do Sul', cnpj: '78.896.000/0001-09',
                       address: 'Av. Goiás, 245')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Rental Cars - Diadema')
    expect(page).to have_content('Rental Cars - São Paulo')
    expect(page).to have_content('Rental Cars - São Caetano do Sul')
  end

  scenario 'and view details' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '99.133.221/0001-03', 
                       address: 'Rua dos Milionários, 1010')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '14.566.342/0001-88',
                       address: 'Av. Jabaquara, 2068')
    Subsidiary.create!(name: 'Rental Cars - São Caetano do Sul', cnpj: '78.896.000/0001-09',
                       address: 'Av. Goiás, 245')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    
    expect(page).to have_content('Rental Cars - Diadema')
    expect(page).to have_content('99.133.221/0001-03')
    expect(page).to have_content('Rua dos Milionários, 1010')
  end

  scenario 'and no subsidiaries are created' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial foi cadastrada')
  end

  scenario 'and return to home page' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '99.133.221/0001-03', 
                       address: 'Rua dos Milionários, 1010')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
  
end