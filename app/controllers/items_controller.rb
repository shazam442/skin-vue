class ItemsController < ApplicationController
  before_action :load_item, only: %i[ show update destroy ]

  def index
    @items = Item.all
  end

  def create
    @item = Item.create!(item_params)
    render :show
  end

  def update
    @item.update!(item_params)
    render :show
  end

  def destroy
    @item.destroy!
    render :show
  end

  private

  def load_item = @item = Item.find(params[:id])

  def item_params = params.require(:item).permit(:name, :wear, :category, :stattrak, :souvenir)
end
