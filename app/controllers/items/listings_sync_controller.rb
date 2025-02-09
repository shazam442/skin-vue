class Items::ListingsSyncController < ApplicationController
  before_action :load_item

  def create = @item.sync_listings

  private

  def load_item = @item = Item.find(params[:id])
end
