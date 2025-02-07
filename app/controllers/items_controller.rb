class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy sync_listings ]

  # GET /items
  def index
    @items = Item.all

    render json: @items.map { |item| format_item(item) }
  end

  # GET /items/1
  def show
    render json: format_item(@item)
  end


  def sync_listings
    @item.sync_listings

    render json: format_item(@item)
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: format_item(@item), status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: format_item(@item)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
  end

  private

  def format_item(item)
    item.as_json.merge(img_url: item.img_url, cheapest_listing: item.cheapest_listing&.as_json)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.includes(:listings).find(params[:id])
  end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :wear, :category, :stattrak, :souvenir)
    end
end
