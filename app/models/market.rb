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
