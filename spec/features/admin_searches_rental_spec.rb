require 'rails_helper'

feature 'Admin searches rental' do
  scenario 'and finds one match' do
    user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                            car_category: car_category, user: user, client: client)
    second_rental = Rental.create!(start_date: Date.current, end_date: 1.day.from_now,
                                   car_category: car_category, user: user, 
                                   client: client)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    fill_in 'Buscar locação', with: rental.token
    click_on 'Buscar'

    expect(page).to have_content(rental.token)
    expect(page).to_not have_content(second_rental.token)
    expect(page).to have_content(rental.car_category.name)
    expect(page).to have_content(rental.client.name)
    expect(page).to have_content(rental.user.email)
  end
end