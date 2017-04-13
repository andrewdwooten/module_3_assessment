class BestBuyService

  def initialize
    @conn = Faraday.new('https://api.bestbuy.com/v1/')
end
