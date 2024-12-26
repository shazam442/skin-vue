class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show update destroy ]

  # GET /items
  def index
    @items = Item.all

    render json: @items.map { |item| item.as_json.merge(img_url: item.img_url) }
  end

  # GET /items/1
  def show
    render json: @item.as_json.merge(img_url: @item.img_url)
  end

  def update
    @items = Item.all
    Skinbaron::Service.new(@items).sync_listings_to_db

    render json: { success: true }
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item.as_json.merge(img_url: @item.img_url), status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item.as_json.merge(img_url: @item.img_url)
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:name, :wear, :category, :stattrak, :souvenir)
    end
end
