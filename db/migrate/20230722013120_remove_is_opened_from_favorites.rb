class RemoveIsOpenedFromFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_column :favorites, :is_opened, :boolean
  end
end
