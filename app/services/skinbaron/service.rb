module Skinbaron
class Service
  def initialize(items)
    @items = Array(items)
    @query_names = @items.map { |item| item.market_hash_name(wear: false, sttrk_souv: false) }
    @item_names = @items.map { |item| item.market_hash_name }
    @market = Market.find_by(name: "skinbaron")
  end

  def sync_listings_to_db
    skinbaron_listings = SkinbaronClient.search(item: query_names.join(";"))["sales"]

    skinbaron_listings.each do |listing_data|
      # if listing is already in our database, update it
      listing = Listing.find_by(uid: listing_data["id"])
      if listing
        listing.update!(price: listing_data["price"], wear: listing_data["wear"])
        next
      end

      # if not in db, extract item data from market name and check if item exists in our database
      byebug

      # Skip if we don't have this item in our database
      next unless item

      # Find or create the market page for this item


      # Create the listing
      Listing.find_or_create_by!(uid: listing_data["id"]) do |listing|
        listing.market_page = market_page
        listing.price = listing_data["price"]
        listing.wear = listing_data["wear"]
      end
    end
  end
end
end
