class ApisController < ApplicationController
  before_action :set_item

  def skinbaron
    item_name = @item.market_hash_name(wear: false, sttrk_souv: false)
    render json: SkinbaronClient.search(item: item_name)
  end

  def set_item
    @item = Item.find params[:item_id]
  end
end
