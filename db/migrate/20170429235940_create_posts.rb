class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string  :title
      t.text    :body
      t.boolean :visible, default: true
      t.integer :user_id

      t.timestamps
    end
  end
end
