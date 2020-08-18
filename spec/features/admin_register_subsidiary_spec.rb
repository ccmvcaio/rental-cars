require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'from index page' do
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_link('Registrar uma nova filial',
                               href: new_subsidiary_path)
  end

  scenario 'succesfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar uma nova filial'
    
    fill_in 'Nome', with: 'Rental Cars - Rio de Janeiro'
    fill_in 'CNPJ', with: '78.896.000/0001-09'
    fill_in 'Endereço', with: 'Av. Brasil, 6588'
    click_on 'Enviar'

    expect(current_path).to eq subsidiary_path(Subsidiary.last)
    expect(page).to have_content('Rental Cars - Rio de Janeiro')
    expect(page).to have_content('78.896.000/0001-09')
    expect(page).to have_content('Av. Brasil, 6588')
    expect(page).to have_content('Voltar')
  end
end