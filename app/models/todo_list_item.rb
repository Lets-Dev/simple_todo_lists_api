class TodoListItem < ApplicationRecord
  enum status: [:pending, :done]
  belongs_to :todo_list

  validates :todo_list_id, presence: true
end