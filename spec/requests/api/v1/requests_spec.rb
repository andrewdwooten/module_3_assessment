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
    items = JSON.parse(response.body)
    first = items.first
    last = items.last

    expect(response.status).to eq(200)

    expect(first['name']).to eq('test1')
    expect(first['description']).to eq('cool_thing1')
    expect(first['image_url']).to eq('image1')
    expect(first.has_key?('created_at')).to eq(false)
    expect(first.has_key?('udpated_at')).to eq(false)


    expect(last['name']).to eq('test2')
    expect(last['description']).to eq('cool_thing2')
    expect(last['image_url']).to eq('image2')
    expect(last.has_key?('created_at')).to eq(false)
    expect(last.has_key?('udpated_at')).to eq(false)
  end
end
