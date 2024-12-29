class AddUniqueIndexToMarkets < ActiveRecord::Migration[7.2]
  def change
    add_index :markets, :name, unique: true
  end
end
