class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string  :name
      t.boolean :done, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
