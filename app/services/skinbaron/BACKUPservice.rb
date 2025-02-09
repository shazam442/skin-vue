module Skinbaron
class Service
  def initialize(items)
    @items = Array(items)
    @market = Market.skinbaron
    @market_page = nil
  end

  def self.sync_to_db(items)
    new(items.first).sync_to_db if items.one?
    new(items).sync_multiple_to_db if items.many?
  end

  def sync_to_db
    trigger_sync_for_item(@items.first)
  end

  private

  def trigger_sync_for_item(item)
    listings = fetch_listings!(item)
    upsert_listings!(listings)
  end

  def upsert_listings!(listings)
    listing_attributes = listings.map { listing_to_params(_1) }

    Listing.upsert_all(
      listing_attributes,
      unique_by: :uid,
      returning: false
    )
  end

  def fetch_listings!(item)
    query_params = build_query_params(item)
    SkinbaronClient.search(**query_params, request_delay: 1)
  end

  def market_page
    @market_page ||= MarketPage.find_or_create_by(market: @market, item: @items.first)
  end

  def listing_to_params(listing)
    {
      market_page_id: market_page.id,
      uid: listing["id"],
      float: listing["wear"],
      price: listing["price"]
    }
  end

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
