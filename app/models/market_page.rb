# == Schema Information
#
# Table name: market_pages
#
#  id                 :integer          not null, primary key
#  min_price          :decimal(, )
#  quantity_available :integer
#  volume_sold        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  item_id            :integer          not null
#  market_id          :integer          not null
#
# Indexes
#
#  index_market_pages_on_item_id                (item_id)
#  index_market_pages_on_market_id              (market_id)
#  index_market_pages_on_market_id_and_item_id  (market_id,item_id) UNIQUE
#
# Foreign Keys
#
#  item_id    (item_id => items.id)
#  market_id  (market_id => markets.id)
#
class MarketPage < ApplicationRecord
  belongs_to :market
  belongs_to :item
  has_many :listings, dependent: :destroy

  validates :market_id, uniqueness: { scope: :item_id }

  scope :skinbaron, -> { where(market: Market.find_by(name: "skinbaron")) }
  scope :steam, -> { where(market: Market.find_by(name: "steam")) }
  scope :skinport, -> { where(market: Market.find_by(name: "skinport")) }
end
