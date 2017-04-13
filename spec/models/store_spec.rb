require 'rails_helper'

describe Store do
  it '.get_stores_by_zip' do
    VCR.use_cassette('models/store/get_stores_by_zip') do
      store = Store.new
      stores = store.get_stores_by_zip('80202')
      first_store = stores.first

      expect(stores.count).to eq(16)
      expect(first_store).to be_a(Store)
      expect(first_store).to respond_to(:longName)
      expect(first_store).to respond_to(:distance)
      expect(first_store).to respond_to(:city)
      expect(first_store).to respond_to(:storeType)
    end
  end
  it '#format_stores' do
    VCR.use_cassette('models/store/format_stores') do
      store = Store.new
      searcher = BestBuyService.new
      raw_stores = searcher.get_stores_by_zip('80202')[:stores]
      stores = store.format_stores(raw_stores)
      first_store = stores.first

      expect(stores.count).to eq(16)
      expect(first_store).to be_a(Store)
      expect(first_store).to respond_to(:longName)
      expect(first_store).to respond_to(:distance)
      expect(first_store).to respond_to(:city)
      expect(first_store).to respond_to(:storeType)
    end
  end
end
