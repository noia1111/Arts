class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
    t.integer :user_id, null:false
    t.integer :painting_id, null:false
    t.text :caption
    t.boolean :is_opened, null: false
      
      t.timestamps
    end
    add_index :favorites, :id
  end
end
