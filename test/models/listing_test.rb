# == Schema Information
#
# Table name: listings
#
#  id             :integer          not null, primary key
#  float          :decimal(, )
#  price          :decimal(, )      not null
#  uid            :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  market_page_id :integer          not null
#
# Indexes
#
#  index_listings_on_market_page_id          (market_page_id)
#  index_listings_on_market_page_id_and_uid  (market_page_id,uid) UNIQUE
#
# Foreign Keys
#
#  market_page_id  (market_page_id => market_pages.id)
#
require "test_helper"

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
