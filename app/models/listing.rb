class Listing < ApplicationRecord
  belongs_to :market_page
  delegate :item, to: :market_page
end
