require 'rails_helper'

describe 'api v1 requests' do
  attr_reader :item, :item2
  before(:each) do
    @item = Item.create(name:        'test1',
                       description: 'cool_thing1',
                       image_url:   'image1')
    @item2 = Item.create(name:        'test2',
                        description: 'cool_thing2',
                        image_url:   'image2')
  end
  it 'can return all items' do

    get 'api/v1/items'

    byebug
  end
end
