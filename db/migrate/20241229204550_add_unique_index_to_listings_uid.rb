class AddUniqueIndexToListingsUid < ActiveRecord::Migration[7.2]
  def change
    add_index :listings, :uid, unique: true, name: 'index_listings_on_uid'
  end
end
