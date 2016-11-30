require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Todo Lists' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  get 'todo_lists' do
    example_request 'Listing to-do lists' do
      3.times do
        create(:todo_list)
      end
      do_request

      expect(status).to eq 200

      json = JSON.parse(response_body)
      expect(json.size).to eq(3)
    end
  end

  get 'todo_lists/:id' do
    let(:todo_list) { create(:todo_list) }
    let(:id) { todo_list.id }

    example_request 'Getting a to-do list' do
      expect(status).to eq 200

      json = JSON.parse(response_body)
      expect(json['id']).to eq(id)
      expect(json['label']).to eq(todo_list.label)
    end
  end

  post 'todo_lists' do
    parameter :label, 'Title of the list', required: true, scope: :todo_list
    parameter :color, 'Color of the list (hexadecimal)', required: false, scope: :todo_list

    let(:label) { Faker::StarWars.planet }
    let(:color) { Faker::Color.hex_color }

    example_request 'Creating a to-do list' do
      expect(status).to eq 201
      json = JSON.parse(response_body)
      expect(json['id']).to be_present
      expect(json['label']).to eq(label)
      expect(json['color']).to eq(color)
    end
  end

  put 'todo_lists/:id' do
    parameter :label, 'Title of the list', required: true, scope: :todo_list
    parameter :color, 'Color of the list (hexadecimal)', required: false, scope: :todo_list

    let(:todo_list) { create(:todo_list) }
    let(:id) { todo_list.id }
    let(:label) { Faker::StarWars.planet }
    let(:color) { Faker::Color.hex_color }

    example_request 'Editing a to-do list' do
      expect(status).to eq 200
      json = JSON.parse(response_body)
      expect(json['id']).to eq(id)
      expect(json['label']).to eq(label)
      expect(json['color']).to eq(color)
    end
  end

  delete 'todo_lists/:id' do
    let(:todo_list) { create(:todo_list) }
    let(:id) { todo_list.id }


    example_request 'Deleting a to-do list' do
      expect(status).to eq 204
    end
  end
end