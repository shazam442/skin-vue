class MarketPage < ApplicationRecord
  belongs_to :market
  belongs_to :item
  has_many :listings, dependent: :destroy

  validates :market_id, uniqueness: { scope: :item_id }

  scope :skinbaron, -> { where(market: Market.find_by(name: "skinbaron")) }
  scope :steam, -> { where(market: Market.find_by(name: "steam")) }
  scope :skinport, -> { where(market: Market.find_by(name: "skinport")) }
end
