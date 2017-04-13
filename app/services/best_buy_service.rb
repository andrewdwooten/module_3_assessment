class BestBuyService
  attr_reader :conn, :auth, :show, :type, :page_size

  def initialize
    @conn = Faraday.new('https://api.bestbuy.com')
    @auth = "apiKey=#{ENV['STORE_KEY']}"
    @show = 'show=longName,storeType,city,distance'
    @type = 'format=json'
    @page_size = 'pageSize=16'
  end

  def get_stores_by_zip(zip)
    parse(conn.get("/v1/stores(area(#{zip},25))?#{type}&#{show}&#{page_size}&#{auth}"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
