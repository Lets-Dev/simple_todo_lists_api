class CreateTodoListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_list_items do |t|
      t.string :label
      t.integer :status, default: 0
      t.belongs_to :todo_list

      t.timestamps
    end
  end
end
