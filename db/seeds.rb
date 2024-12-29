# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

markets = [
  Market.find_or_create_by!(name: "skinbaron"),
  Market.find_or_create_by!(name: "steam"),
  Market.find_or_create_by!(name: "skinport")
]

items = [
  Item.find_or_create_by!(name: "Galil AR | Metallic Squeezer", wear: :minimal_wear, category: :weapon, stattrak: false, souvenir: false),
  Item.find_or_create_by!(name: "PP-Bizon | Cold Cell", wear: :factory_new, category: :weapon, stattrak: false, souvenir: false),
  Item.find_or_create_by!(name: "Glock-18 | Teal Graf", wear: :factory_new, category: :knife, stattrak: false, souvenir: false),
  Item.find_or_create_by!(name: "Nova | Yorkshire", wear: :factory_new, category: :weapon, stattrak: false, souvenir: false)
]

items.each do |item|
  markets.each do |market|
    MarketPage.find_or_create_by!(market: market, item: item)
  end
end
