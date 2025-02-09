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
class Market < ApplicationRecord
  has_many :api_requests

  enum :name, {
    steam: 0,
    skinbaron: 1,
    skinport: 2
  }

  scope :steam, -> { where(name: :steam).take }
  scope :skinbaron, -> { where(name: :skinbaron).take }
  scope :skinport, -> { where(name: :skinport).take }
end
