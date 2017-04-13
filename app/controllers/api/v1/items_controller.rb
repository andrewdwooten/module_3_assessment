class Api::V1::ItemsController < ApplicationController
  attr_reader :item

  before_action :set_item, only: [:show, :destroy]

  def index
    render json: Item.all
  end

  def show
    render json: item
  end

  def destroy
    if item.nil?
      render json: 'Something went terribly wrong'
    else item.destroy
      render status: 204, json: ''
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render status: 201, json: item
    else
      render json: 'Something went terribly wrong'
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name,
                                 :description,
                                 :image_url)
  end
end
