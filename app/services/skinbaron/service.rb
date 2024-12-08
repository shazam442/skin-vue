module Skinbaron
class Service
  def initialize(item)
    @client = Client.new(item)
    @item = item
  end

  def get_listings
    sync_listings_to_db
  end

  def sync_listings_to_db
    items = @client.search["sales"]

    items.select! { |item| item["market_name"] == @item.market_hash_name }

    items.map do |item|
      Listing.create!(
        market_page: MarketPage.find_or_create_by!(market: Market.find_by(name: "skinbaron").id, item: @item.id),
        price: item["price"],
        wear: item["wear"],
        uid: item["id"],
      )
    end
  end
end
end
