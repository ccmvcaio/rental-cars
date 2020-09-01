require 'rails_helper'

feature 'Admin view rentals' do
  scenario 'successfully' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: '02/01/2030', end_date: '20/01/2030',
                            car_category: car_category, user: user, client: client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'

    expect(page).to have_content('Santos Silva')
    expect(page).to have_content('418.882.130-27')
    expect(page).to have_content('02/01/2030')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and view details of a rental' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: '02/01/2030', end_date: '20/01/2030',
                            car_category: car_category, user: user, client: client)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Santos Silva - 418.882.130-27 - 02/01/2030'

    expect(page).to have_content('02/01/2030')
    expect(page).to have_content('20/01/2030')
    expect(page).to have_content('Santos Silva')
    expect(page).to have_content('santos.silva@gmail.com')
    expect(page).to have_content('418.882.130-27')
    expect(page).to have_link('Voltar', href: rentals_path)
  end

  scenario 'and just show rentals button if logged in' do
    visit root_path

    expect(page).not_to have_link('Locações')
  end

  scenario 'and must be logged in' do
    visit rentals_path
    
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'and must be logged in to view details' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: '02/01/2030', end_date: '20/01/2030',
                            car_category: car_category, user: user, client: client)

    visit rental_path(rental)

    expect(current_path).to eq new_user_session_path
  end
end