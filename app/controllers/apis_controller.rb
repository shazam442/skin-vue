class ApisController < ApplicationController
  def skinbaron
    skinbaron = Skinbaron::Client.new
    render json: skinbaron.dev
  end

  def fetch_price
  end
end
