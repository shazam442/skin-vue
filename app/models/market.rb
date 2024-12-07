class Market < ApplicationRecord
  has_many :api_requests

  enum name: {
    steam: 0,
    skinbaron: 1,
    skinport: 2
  }
end
