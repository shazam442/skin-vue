# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  category   :integer          not null
#  name       :string           not null
#  souvenir   :boolean
#  stattrak   :boolean
#  wear       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_items_on_name_and_wear_and_stattrak_and_souvenir  (name,wear,stattrak,souvenir) UNIQUE
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
