class MarketPagesController < ApplicationController
  def index
    @market_pages = MarketPage.all
  end
end
