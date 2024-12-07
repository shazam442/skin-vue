class ApiRequest < ApplicationRecord
  belongs_to :target, polymorphic: true
end
