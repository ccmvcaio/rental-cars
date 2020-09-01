require 'rails_helper'

feature 'Admin schedule rental' do
  scenario 'successfully' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                        car_insurance: 58.5, third_party_insurance: 10.5)
    Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                   cpf: '418.882.130-27')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar nova locação'
    fill_in 'Data de início', with: '12/12/2030'
    fill_in 'Data de término', with: '22/12/2030'
    select 'Santos Silva - 418.882.130-27', from: 'Cliente'
    select 'Econo', from: 'Categoria de carro'
    click_on 'Agendar'

    expect(page).to have_content('12/12/2030')
    expect(page).to have_content('22/12/2030')
    expect(page).to have_content('Santos Silva')
    expect(page).to have_content('santos.silva@gmail.com')
    expect(page).to have_content('418.882.130-27')
    expect(page).to have_content('Agendamento realizado com sucesso!')
  end

  scenario 'and attributes cannot be blank' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                        car_insurance: 58.5, third_party_insurance: 10.5)
    Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                   cpf: '418.882.130-27')

  login_as(user, scope: :user)
  visit root_path
  click_on 'Locações'
  click_on 'Agendar nova locação'
  click_on 'Agendar'

  expect(page).to have_content('não pode ficar em branco', count: 2)
  end

  scenario 'and must be logged in to schedule rental' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')

    visit new_rental_path

    expect(current_path).to eq new_user_session_path
  end
end