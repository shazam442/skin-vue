class MarkePagesController < ApplicationController
  def index
    @market_pages = MarketPage.all
  end
end
