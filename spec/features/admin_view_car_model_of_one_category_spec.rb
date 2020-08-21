require 'rails_helper'

feature 'Admin view car model of one category' do
  scenario 'and must be signed in' do
    visit root_path
    click_on 'Modelos de carro'

    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and choose car category' do
    user = User.create!(name: 'Caio César Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category_top = CarCategory.create!(name: 'Top', daily_rate: 105.5,
                                           car_insurance: 58.5,
                                           third_party_insurance: 10.5)
    car_category_flex = CarCategory.create!(name: 'Flex', daily_rate: 95.5,
                                           car_insurance: 42.99,
                                           third_party_insurance: 9.5)
    CarModel.create!(name: 'Jetta', year: 2020, motorization: '2.0',
                     manufacturer: 'Volkswagen', fuel_type: 'Flex',
                     car_category: car_category_top)
    CarModel.create!(name: 'Cobalt', year: 2020, motorization: '1.6',
                     manufacturer: 'Chevrolet', fuel_type: 'Etanol',
                     car_category: car_category_flex)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Top')
    expect(page).to have_content('Flex')
  end

  xscenario 'successfully' do
    user = User.create!(name: 'Caio César Valério', email: 'caio.valerio@gmail.com',
                        password: '123456')
    car_category_top = CarCategory.create!(name: 'Top', daily_rate: 105.5,
                                           car_insurance: 58.5,
                                           third_party_insurance: 10.5)
    car_category_flex = CarCategory.create!(name: 'Flex', daily_rate: 95.5,
                                           car_insurance: 42.99,
                                           third_party_insurance: 9.5)
    CarModel.create!(name: 'Jetta', year: 2020, motorization: '2.0',
                     manufacturer: 'Volkswagen', fuel_type: 'Gasolina',
                     car_category: car_category_top)
    CarModel.create!(name: 'Cobalt', year: 2020, motorization: '1.6',
                     manufacturer: 'Chevrolet', fuel_type: 'Etanol',
                     car_category: car_category_flex)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de carro'
    click_on 'Flex'

    expect(page).to have_content('Jetta')
    expect(page).to have_content('2020', count: 2)
    expect(page).to have_content('2.0')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('Gasolina')
    expect(page).to have_content('Top')
    expect(page).to have_content('Cobalt')
    expect(page).to have_content('1.6')
    expect(page).to have_content('Chevrolet')
    expect(page).to have_content('Etanol')
    expect(page).to have_content('Flex')
    expect(page).to have_link('Voltar', href:car_models_path)
  end
end    