class Store < OpenStruct

  attr_reader :store_searcher

  def store_searcher
    @store_searcher = BestBuyService.new
  end

  def get_stores_by_zip(zip)
    raw_stores = store_searcher.get_stores_by_zip(zip)[:stores]
    format_stores(raw_stores)
  end

  def format_stores(stores)
    stores.map do |store|
      Store.new(longName:     store[:longName],
                storeType:    store[:storeType],
                city:         store[:city],
                distance:     store[:distance],
                phone:        store[:phone])
    end
  end
end
