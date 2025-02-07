class CreateMarketPages < ActiveRecord::Migration[7.2]
  def change
    create_table :market_pages do |t|
      t.references :market, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.decimal :min_price
      t.integer :quantity_available
      t.integer :volume_sold

      t.timestamps
    end

    add_index :market_pages, [ :market_id, :item_id ], unique: true
  end
end
