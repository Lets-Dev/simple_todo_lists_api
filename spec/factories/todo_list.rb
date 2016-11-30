require 'faker'

FactoryGirl.define do
  factory :todo_list do |f|
    f.label { Faker::StarWars.planet }
    f.color { Faker::Color.hex_color }
  end
end