class ApisController < ApplicationController
  def skinbaron
    item = Item.find params[:item_id]

    skinbaron_service = Skinbaron::Service.new(item)
    render json: skinbaron_service.get_listings
  end
end
