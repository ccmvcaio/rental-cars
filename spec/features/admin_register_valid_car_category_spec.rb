require 'rails_helper'

feature 'Admin register valid car category' do
  scenario 'and must be sined in' do
    visit root_path
    click_on 'Categorias'

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and name must be unique' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')
    CarCategory.create!(name: 'Top', daily_rate: 105.5, car_insurance: 58.5,
                        third_party_insurance: 10.5)

    login_as(user,scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: 'Top'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do carro', with: '50'
    fill_in 'Seguro para terceiros', with: '10'
    click_on 'Enviar'

    expect(page).to have_content('já está em uso')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'Caio César Valério',email: 'caio.valerio@gmail.com',
                        password: '123456')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar uma nova categoria'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do carro', with: ''
    fill_in 'Seguro para terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco', count: 4)
  end
end
