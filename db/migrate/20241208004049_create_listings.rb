class CreateListings < ActiveRecord::Migration[7.2]
  def change
    create_table :listings do |t|
      t.references :market_page, null: false, foreign_key: true
      t.decimal :price, null: false
      t.decimal :wear
      t.string :uid

      t.timestamps
    end
  end
end
