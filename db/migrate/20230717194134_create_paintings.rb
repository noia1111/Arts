class CreatePaintings < ActiveRecord::Migration[6.1]
  def change
    create_table :paintings do |t|
    t.integer :user_id, null:false
    t.string :title, null:false
    t.text :caption
    t.boolean :is_opened, null: false, default: true
      t.timestamps
    end
    add_index :paintings, :id
  end
end
