require 'rails_helper'

describe BestBuyService do
  it 'returns a list of stores within 25 miles of zip code' do
    VCR.use_cassette('services/bestbuy') do
      searcher = BestBuyService.new
      raw_stores = searcher.get_stores_by_zip('80202')[:stores]
      first_store = raw_stores.first

      expect(raw_stores.count).to eq(16)
      expect(first_store.has_key?(:longName)).to eq(true)
      expect(first_store.has_key?(:storeType)).to eq(true)
      expect(first_store.has_key?(:distance)).to eq(true)
      expect(first_store.has_key?(:city)).to eq(true)
    end
  end
end
