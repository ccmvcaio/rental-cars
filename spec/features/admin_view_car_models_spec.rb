require 'rails_helper'

feature 'admin view car models' do
  scenario 'succesfully' do
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    CarModel.create!(name: 'Sandero', year: 2020, manufacturer: 'Renault',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'Up', year: 2018, manufacturer: 'Volkswagen',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    
    expect(page).to have_content('Sandero')
    expect(page).to have_content('2020')
    expect(page).to have_content('Renault')
    expect(page).to have_content('Up')
    expect(page).to have_content('2018')
    expect(page).to have_content('Volkswagen')
    expect(page).to have_content('Econo', count: 2)
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and no car model registered' do
    visit root_path
    click_on 'Modelos de carro'

    expect(page).to have_content('Nenhum modelo de carro cadastrado')
  end

  scenario 'and show details' do
    car_category = CarCategory.create!(name: 'Econo', daily_rate: 105.5,
                                       car_insurance: 58.5, third_party_insurance: 10.5)
    CarModel.create!(name: 'Sandero', year: 2020, manufacturer: 'Renault',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')
    CarModel.create!(name: 'Up', year: 2018, manufacturer: 'Volkswagen',
                     motorization: '1.0', car_category: car_category, fuel_type: 'Flex')

    visit root_path
    click_on 'Modelos de carro'
    click_on 'Renault Sandero - 2020 - Econo'

    expect(page).to have_content('Sandero')
    expect(page).to have_content('2020')
    expect(page).to have_content('Renault')
    expect(page).to have_content('1.0')
    expect(page).to have_content('Econo')
    expect(page).to have_content('Flex')
    expect(page).to have_link('Voltar', href: car_models_path)
  end
end