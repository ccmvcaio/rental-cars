require 'rails_helper'

feature 'admin register car model' do
  scenario 'and must be signed in' do
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'successfully' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    fill_in 'Nome', with: 'Sandero'
    fill_in 'Ano', with: 2020
    fill_in 'Fabricante', with: 'Renault'
    fill_in 'Motorização', with: '1.0'
    select 'Econo', from: 'Categoria de carro'
    fill_in 'Tipo de combustível', with: 'Flex'
    click_on 'Enviar'

    expect(page).to have_content('Sandero')
    expect(page).to have_content('2020')
    expect(page).to have_content('Renault')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Econo')
    expect(page).to have_content('Flex')
  end

  scenario 'and spaces cant be blank' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
                        
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Registrar um modelo de carro'
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 6)
    expect(page).to have_content('Categoria de carro é obrigatório(a)')
  end

end