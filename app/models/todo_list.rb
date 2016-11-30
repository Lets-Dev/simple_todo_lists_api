class TodoList < ApplicationRecord
  has_many :todo_list_items

  validates :label, presence: true, uniqueness: true
  validates :color, format: {with: /#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})/, message: 'only hexadecimal colors'}
end
