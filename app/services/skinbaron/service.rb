module Skinbaron
  class Service
    def initialize(items)
      raise ArgumentError, "Items must be an array" unless items.is_a?(Array)
      @item_groups = Item.group_by_attributes(items)
    end

    def self.sync_to_db(items)
      new(Array(items)).sync_to_db
    end

    def sync_to_db
      @item_groups.map do |attributes, items|
        listings_group = fetch_listings!(attributes, items)
        upsert_listings!(listings_group)
      end
    end

    private

    def upsert_listings!(listings_group)
      listing_attributes = listings_group.map do |l|
        item = Item.find_or_create_by_market_hash_name(l["market_name"])
        {
          market_page: market_page(item),
          uid: l["id"],
          float: l["wear"],
          price: l["price"]
        }
      end

      Listing.upsert_all(
        listing_attributes,
        unique_by: :uid,
        returning: false
      )
    end

    def fetch_listings!(attributes, items)
      query_params = build_group_query(attributes, items)
      SkinbaronClient.search(**query_params, request_delay: 1)
    end

    def market_page(item)
      MarketPage.find_or_create_by(market: Market.skinbaron, item: item)
    end

    def build_group_query(attributes, items)
      float_range = Item.float_range(wear: attributes[:wear])

      {
        items: items.map { _1.market_hash_name(wear: false, sttrk_souv: false) },
        pages: -1,
        min_wear: float_range.begin,
        max_wear: float_range.end,
        stackable: false
      }.tap do |h|
        h[:stattrak] = attributes[:stattrak] unless attributes[:stattrak].nil?
        h[:souvenir] = attributes[:souvenir] unless attributes[:souvenir].nil?
      end
    end
  end
end
