export interface ApiRequest {
  target_type: string;
  target_id: number;
  target_url: string;
  success: boolean;
  request_body?: Record<string, any>;
  response_body?: Record<string, any>;
  response_code?: number;
}

export interface Item {
  id: number;
  name: string;
  wear: 'no_wear' | 0 | 'factory_new' | 1 | 'minimal_wear' | 2 | 'field_tested' | 3 | 'well_worn' | 4 | 'battle_scarred' | 5;
  category: 'weapon' | 0 | 'knife' | 1 | 'gloves' | 2;
  stattrak: boolean;
  souvenir: boolean;
  img_url: string;
  cheapest_listing?: Listing;
  listings?: Listing[];
  market_pages?: MarketPage[];
  market?: Market;
  created_at?: string;
  updated_at?: string;
}

export interface Listing {
  id: number;
  market_page_id: number;
  price: number;
  float?: number;
  uid?: string;
}

export interface MarketPage {
  id: number;
  market_id: number;
  item_id: number;
  min_price?: number;
  quantity_available?: number;
  volume_sold?: number;
}

export interface Market {
  id: number;
  name: number;
}
