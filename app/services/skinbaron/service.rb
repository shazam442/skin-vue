module Skinbaron
class Service
  def initialize(items)
    @items = Array(items)
    @market = Market.skinbaron
    @market_page = nil
  end

  def sync_to_db
    if @items.one?
      sync_one(@items.first)
    else
      # sync_multiple(@items)
    end
  end

  def sync_one(item)
    market_page = MarketPage.find_or_create_by(market: @market, item: item)

    # Extract query parameters to a separate method for clarity
    query_params = build_query_params(item)
    listings = SkinbaronClient.search(**query_params, request_delay: 1)

    # Use bulk insert instead of individual upserts for better performance
    listing_attributes = listings.map do |listing|
      {
        market_page_id: market_page.id,
        uid: listing["id"],
        float: listing["wear"],
        price: listing["price"],
        created_at: Time.current,
        updated_at: Time.current
      }
    end

    Listing.upsert_all(
      listing_attributes,
      unique_by: :uid,
      returning: false
    )
  end

  private

  def build_query_params(item)
    {
      items: item.market_hash_name(wear: false, sttrk_souv: false),
      pages: -1,
      min_wear: item.float_range.begin,
      max_wear: item.float_range.end,
      stattrak: item.stattrak?,
      souvenir: item.souvenir?,
      stackable: false
    }
  end
end
end
