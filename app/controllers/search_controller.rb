class SearchController < ApplicationController
  attr_reader :store
  before_action :set_store, only: [:index]
  
  def index
    @stores = store.get_stores_by_zip(params[:search])
  end

  private
  def set_store
    @store = Store.new
  end
end
