require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Todo List Items' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get 'todo_list_items' do
    example_request 'Listing to-do list items' do
      3.times do
        create(:todo_list_item)
      end
      do_request

      expect(status).to eq 200

      json = JSON.parse(response_body)
      expect(json.size).to eq(3)
    end
  end

  get 'todo_list_items/:id' do
    let(:todo_list_item) { create(:todo_list_item) }
    let(:id) { todo_list_item.id }

    example_request 'Getting a to-do list item' do
      expect(status).to eq 200

      json = JSON.parse(response_body)
      expect(json['id']).to eq(id)
      expect(json['label']).to eq(todo_list_item.label)
      expect(json['status']).to eq(todo_list_item.status)
    end
  end

  post 'todo_list_items' do
    parameter :label, 'Label of the item', required: true, scope: :todo_list_item
    parameter :status, 'Status of the item (pending or done)', required: true, scope: :todo_list_item
    parameter :todo_list_id, 'ID of the parent to-do list', required: true, scope: :todo_list_item

    let(:label) { Faker::StarWars.planet }
    let(:status) { 'pending' }
    let(:todo_list_id) {create(:todo_list).id}

    example_request 'Creating a to-do list item' do
      expect(response_status).to eq 201
      json = JSON.parse(response_body)
      expect(json['id']).to be_present
      expect(json['label']).to eq(label)
      expect(json['status']).to eq(status)
    end
  end

  put 'todo_list_items/:id' do
    parameter :label, 'Label of the item', required: true, scope: :todo_list_item
    parameter :status, 'Status of the item (pending or done)', required: true, scope: :todo_list_item
    parameter :todo_list_id, 'ID of the parent to-do list', required: true, scope: :todo_list_item

    let(:todo_list_item) { create(:todo_list_item) }
    let(:id) { todo_list_item.id }
    let(:label) { Faker::StarWars.planet }
    let(:status) { 'done' }
    let(:todo_list_id) {create(:todo_list).id}

    example_request 'Editing a to-do list item' do
      expect(response_status).to eq 200
      json = JSON.parse(response_body)
      expect(json['id']).to eq(id)
      expect(json['label']).to eq(label)
      expect(json['status']).to eq(status)
    end
  end

  delete 'todo_list_items/:id' do
    let(:todo_list_item) { create(:todo_list_item) }
    let(:id) { todo_list_item.id }


    example_request 'Deleting a to-do list item' do
      expect(status).to eq 204
    end
  end
end