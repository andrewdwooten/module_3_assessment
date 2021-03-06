require 'rails_helper'

feature 'user visits root and searches for best buys' do
  scenario 'user is directed to /search and can see stores which are paginated' do
    VCR.use_cassette('features/user_searches_for_stores') do
      visit '/'

      expect(page).to have_selector('#search-form')

      fill_in :search, with: '80202'
      click_on "Search"

      expect(current_path).to eq('/search')

      expect(page).to have_content("16 Total Stores")
      expect(page).to have_selector("#stores_container")
      expect(page).to have_selector("#store_instance", count: 10)

      within all('#store_instance').first do
        expect(page).to have_content('BEST BUY MOBILE - CHERRY CREEK SHOPPING CENTER')
        expect(page).to have_content('DENVER')
        expect(page).to have_content('Mobile SAS')
        expect(page).to have_content('3.45')
        expect(page).to have_content('303-270-9189')
      end

      expect(page).to have_link('2')

      click_link '2'

      expect(current_path).to eq('/search')
      expect(page).to have_content("16 Total Stores")
      expect(page).to have_selector("#stores_container")
      expect(page).to have_selector("#store_instance", count: 6)

      within all('#store_instance').first do
        expect(page).to have_content('BEST BUY - I70 & TOWER RD')
        expect(page).to have_content('AURORA')
        expect(page).to have_content('Big Box')
        expect(page).to have_content('11.65')
        expect(page).to have_content('303-373-9284')
      end
    end
  end
end
