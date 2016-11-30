require 'faker'

FactoryGirl.define do
  factory :todo_list_item do |f|
    f.label { Faker::StarWars.character }
    f.status { Faker::Number.between(0, 1) }
    f.todo_list { FactoryGirl.create(:todo_list) }
  end
end