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
require "test_helper"

class MarketPageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
