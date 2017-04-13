require 'rails_helper'

describe 'api v1' do
  attr_reader :item, :item2
  before(:each) do
    @item = Item.create(name:        'test1',
                       description: 'cool_thing1',
                       image_url:   'image1')
    @item2 = Item.create(name:        'test2',
                        description: 'cool_thing2',
                        image_url:   'image2')
  end
describe 'requests' do
    it 'can return all items' do
      VCR.use_cassette('requests/api/v1/items_index') do
        get 'api/v1/items'
        items = JSON.parse(response.body)
        first = items.first
        last = items.last

        expect(response.status).to eq(200)

        expect(first['name']).to eq(item.name)
        expect(first['description']).to eq(item.description)
        expect(first['image_url']).to eq(item.image_url)
        expect(first.has_key?('created_at')).to eq(false)
        expect(first.has_key?('udpated_at')).to eq(false)


        expect(last['name']).to eq(item2.name)
        expect(last['description']).to eq(item2.description)
        expect(last['image_url']).to eq(item2.image_url)
        expect(last.has_key?('created_at')).to eq(false)
        expect(last.has_key?('udpated_at')).to eq(false)
      end
    end

    it 'can return an item' do
      VCR.use_cassette('requests/api/v1/item_show') do
        get 'api/v1/items/1'
        response_item = JSON.parse(response.body)

        expect(response.status).to eq(200)

        expect(response_item['name']).to eq(item.name)
        expect(response_item['description']).to eq(item.description)
        expect(response_item['image_url']).to eq(item.image_url)
        expect(response_item.has_key?('created_at')).to eq(false)
        expect(response_item.has_key?('udpated_at')).to eq(false)

      end
    end

    it 'can delete an item' do
      VCR.use_cassette('requests/api/v1/item_delete') do

        expect(Item.count).to eq(2)
        delete 'api/v1/items/1'

        expect(response.status).to eq(204)
        expect(Item.count).to eq(1)
        expect(Item.where(id: item.id).empty?).to eq(true)
      end
    end

    it 'can create an item' do
      VCR.use_cassette('requests/api/v1/item_create') do
        creation_params =  {item: {name:        'create_test_name',
                                   description: 'create_test_desc',
                                   image_url:   'create_test_img'}
                           }
        post 'api/v1/items', creation_params


          expect(Item.count).to eq(3)

          test_item = Item.last

          expect(response.status).to eq(201)
          expect(test_item['name']).to eq('create_test_name')
          expect(test_item['description']).to eq('create_test_desc')
          expect(test_item['image_url']).to eq('create_test_img')
      end
    end

    it 'can update an item' do
      VCR.use_cassette('requests/api/v1/item_update') do
        update_params =  {item: {name:        'name_test_update',
                                 description: 'desc_test_update',
                                 image_url:   'img_test_update'}
                           }

        expect(item.name).to eq('test1')
        expect(item.description).to eq('cool_thing1')
        expect(item.image_url).to eq('image1')

        put "api/v1/items/#{item.id}", update_params


          expect(Item.count).to eq(2)

          updated_item = Item.find(item.id)

          expect(response.status).to eq(200)
          expect(updated_item['name']).to eq('name_test_update')
          expect(updated_item['description']).to eq('desc_test_update')
          expect(updated_item['image_url']).to eq('img_test_update')
      end
    end
  end
end
