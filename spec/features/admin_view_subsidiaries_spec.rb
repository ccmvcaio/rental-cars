require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '01.012.123/0001-00', 
                       address: 'Rua dos Milionários, 1010')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '12.123.234/0001-11',
                       address: 'Av. Jabaquara, 2068')
    Subsidiary.create!(name: 'Rental Cars - São Caetano do Sul', cnpj: '23.234.345/0001-22',
                       address: 'Av. Goiás, 245')
    
    visit root_path
    click_on 'Filiais'

    expect(current_path).to eq subsidiaries_path
    expect(page).to have_content('Rental Cars - Diadema')
    expect(page).to have_content('Rental Cars - São Paulo')
    expect(page).to have_content('Rental Cars - São Caetano do Sul')
  end

  scenario 'and view datails' do
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '01.012.123/0001-00', 
                       address: 'Rua dos Milionários, 1010')
    Subsidiary.create!(name: 'Rental Cars - São Paulo', cnpj: '12.123.234/0001-11',
                       address: 'Av. Jabaquara, 2068')
    Subsidiary.create!(name: 'Rental Cars - São Caetano do Sul', cnpj: '23.234.345/0001-22',
                       address: 'Av. Goiás, 245')

    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    
    expect(page).to have_content('Rental Cars - Diadema')
    expect(page).to have_content('01.012.123/0001-00')
    expect(page).to have_content('Rua dos Milionários, 1010')
  end

  scenario 'and no subsidiaries are created' do
    visit root_path
    click_on 'Filiais'

    expect(page).to have_content('Nenhuma filial foi cadastrada')
  end

  scenario 'and return to home page' do
    visit root_path
    click_on 'Filiais'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to subsidiaries page' do
    Subsidiary.create!(name: 'Rental Cars - Diadema', cnpj: '01.012.123/0001-00', 
                       address: 'Rua dos Milionários, 1010')
    
    visit root_path
    click_on 'Filiais'
    click_on 'Rental Cars - Diadema'
    click_on 'Voltar'

    expect(current_path).to eq subsidiaries_path
  end
  
end