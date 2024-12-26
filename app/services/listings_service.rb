class ListingsService
  def initialize(items)
    @items = Array(items)
    @query_names = @items.map { |item| item.market_hash_name(wear: false, sttrk_souv: false) }
    @item_names = @items.map { |item| item.market_hash_name }
  end

  def get_listings
    sync_listings_to_db
  end

  def sync_listings_to_db
    skinbaron_listings = SkinbaronClient.search(item: query_names.join(";"))["sales"]

    # skinbaron_listings.select! { |item| item["market_name"] == @item.market_hash_name }

    skinbaron_listings.map do |item|
      Listing.create!(
        market_page: MarketPage.find_or_create_by!(market: Market.find_by(name: "skinbaron").id, item: @item.id),
        price: item["price"],
        wear: item["wear"],
        uid: item["id"],
      )
    end
  end
end
