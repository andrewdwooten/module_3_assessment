class SearchController < ApplicationController
  attr_reader :store, :search_results, :store_count
  before_action :set_store, only: [:index]
  before_action :search_results, only: [:index]
  before_action :store_count, only: [:index]

  def index
    @count = search_results.count
    @stores = Kaminari.paginate_array(search_results,total_count: search_results.count).page(params[:page]).per(10)
  end

  private
  def set_store
    @store = Store.new
  end

  def search_results
    @store.get_stores_by_zip(params[:search])
  end
end
