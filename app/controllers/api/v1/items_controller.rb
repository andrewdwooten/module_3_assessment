class Api::V1::ItemsController < ApplicationController
  attr_reader :item

  before_action :set_item, only: [:show]

  def index
    render json: Item.all
  end

  def show
    render json: item
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
