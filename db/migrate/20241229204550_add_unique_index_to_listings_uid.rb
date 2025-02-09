class AddUniqueIndexToListingsUid < ActiveRecord::Migration[7.2]
  def change
    add_index :listings, [ :market_page_id, :uid ], unique: true
  end
end
