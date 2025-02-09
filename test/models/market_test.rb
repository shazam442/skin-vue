# == Schema Information
#
# Table name: markets
#
#  id         :integer          not null, primary key
#  name       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_markets_on_name  (name) UNIQUE
#
require "test_helper"

class MarketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
