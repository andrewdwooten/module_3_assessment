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
    VCR.use_cassette('requests/api/v1/items_index') do
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

  it 'can return an item' do
    VCR.use_cassette('requests/api/v1/item_show') do
      get 'api/v1/items/1'
      item = JSON.parse(response.body)

      expect(response.status).to eq(200)

      expect(item['name']).to eq('test1')
      expect(item['description']).to eq('cool_thing1')
      expect(item['image_url']).to eq('image1')
      expect(item.has_key?('created_at')).to eq(false)
      expect(item.has_key?('udpated_at')).to eq(false)

    end
  end

  it 'can return an item' do
    VCR.use_cassette('requests/api/v1/item_delete') do

      expect(Item.count).to eq(2)
      delete 'api/v1/items/1'

      expect(Item.count).to eq(1)
      expect(Item.where(id: item.id).empty?).to eq(true)
    end
  end
end
