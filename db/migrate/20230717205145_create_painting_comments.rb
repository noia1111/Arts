class CreatePaintingComments < ActiveRecord::Migration[6.1]
  def change
    create_table :painting_comments do |t|
    t.integer :user_id, null:false
    t.integer :painting_id, null:false
    t.text :comment, null:false
      t.timestamps
    end
    add_index :painting_comments, :id
  end
end
