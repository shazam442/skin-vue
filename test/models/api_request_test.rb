# == Schema Information
#
# Table name: api_requests
#
#  id            :integer          not null, primary key
#  request_body  :json
#  response_body :json
#  response_code :integer
#  success       :boolean          not null
#  target_type   :string           not null
#  target_url    :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  target_id     :integer          not null
#
# Indexes
#
#  index_api_requests_on_target  (target_type,target_id)
#
require "test_helper"

class ApiRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
