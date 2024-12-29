class MarketPage < ApplicationRecord
  belongs_to :market
  belongs_to :item
  has_many :listings
end
