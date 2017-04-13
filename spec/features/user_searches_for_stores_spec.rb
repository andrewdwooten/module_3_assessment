require 'rails_helper'

feature 'user visits root and searches for best buys' do
  scenario 'user is directed to /search and can see stores' do
    visit '/'

    expect(page).to have_selector('#search-form')

    fill_in :search, with: '80202'
    click_on "Search"

    expect(current_path).to eq('/search')
  end
end
