require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

feature 'User start rental' do
  scenario 'successfully' do
    schedule_user = User.create!(name: 'Caio Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    client = Client.create!(name: 'Santos Silva', email: 'santos.silva@gmail.com',
                            cpf: '418.882.130-27')
    rental = Rental.create!(start_date: '02/01/2030', end_date: '20/01/2030',
                            car_category: car_category, user: schedule_user,
                            client: client)
    car_model = CarModel.create!(name: 'Jetta', year: 2020, motorization: '2.0',
                                 manufacturer: 'Volkswagen', fuel_type: 'Gasolina',
                                 car_category: car_category)
    car = Car.create!(license_plate: 'ABC123', color: 'Preto', car_model: car_model,
                      mileage: 0)
    user = User.create!(name: 'Ninguém', email: 'ninguem@gmail.com',
                        password: '123456')
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on "#{rental.client.name} - #{rental.client.cpf} - 02/01/2030"
    click_on 'Iniciar locação'
    select "#{car_model.name} - #{car.color} - #{car.license_plate}",
            from: 'Carros disponíveis'
    travel_to Time.zone.local(2020, 10, 02, 13, 58, 02)
    click_on 'Iniciar'

    expect(page).to have_content(car_category.name)
    expect(page).to have_content(schedule_user.email)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)

    expect(page).to have_content('Locação iniciada com sucesso')
    expect(page).to have_content(user.email)
    expect(page).to have_content(car_model.name)
    expect(page).to have_content(car.license_plate)
    expect(page).to have_content(car.color)
    expect(page).not_to have_link('Iniciar locação')
    expect(page).to have_content("02 de outubro de 2020, 13:58:02")
  end
end