# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  category   :integer          not null
#  name       :string           not null
#  souvenir   :boolean
#  stattrak   :boolean
#  wear       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_items_on_name_and_wear_and_stattrak_and_souvenir  (name,wear,stattrak,souvenir) UNIQUE
#
class Item < ApplicationRecord
  has_many :market_pages, dependent: :destroy
  has_many :listings, through: :market_pages

  validates :name, uniqueness: { scope: [ :wear, :stattrak, :souvenir ] }
  validate :stattrak_and_souvenir_are_mutually_exclusive

  enum :wear, {
    no_wear: 0,
    factory_new: 1,
    minimal_wear: 2,
    field_tested: 3,
    well_worn: 4,
    battle_scarred: 5
  }

  enum :category, {
    weapon: 0,
    knife: 1,
    gloves: 2
  }

  def self.group_by_attributes(items = all)
    items.group_by do |item|
      {
        wear: item.wear,
        stattrak: item.stattrak,
        souvenir: item.souvenir
      }
    end
  end

  def self.find_or_create_by_market_hash_name(market_hash_name)
    # Extract attributes from market hash name
    is_knife = market_hash_name.start_with?("★")
    is_stattrak = market_hash_name.include?("StatTrak™")
    is_souvenir = market_hash_name.include?("Souvenir")

    # Remove special prefixes to get the base name and wear
    name = market_hash_name
      .delete_prefix("★ ")
      .delete_prefix("StatTrak™ ")
      .delete_prefix("Souvenir ")

    # Extract wear if present (everything between last parentheses)
    wear = :no_wear
    if name =~ /\((.*)\)$/
      wear_text = $1
      wear = case wear_text
      when "Factory New" then :factory_new
      when "Minimal Wear" then :minimal_wear
      when "Field-Tested" then :field_tested
      when "Well-Worn" then :well_worn
      when "Battle-Scarred" then :battle_scarred
      end
      # Remove wear from name
      name = name.sub(/\s*\(.*\)$/, "")
    end

    # Determine category
    category = if is_knife
      :knife
    elsif name.include?("Gloves") || name.include?("Wraps") || name.include?("Hand Wraps")
      :gloves
    else
      :weapon
    end

    # Find or create the item
    find_or_create_by!(
      name: name.strip,
      wear: wear,
      stattrak: is_stattrak,
      souvenir: is_souvenir,
      category: category
    )
  end

  def sync_listings
    Skinbaron::Service.sync_to_db(self)
  end

  def cheapest_listing = listings.order(:price).first

  def img_url = "https://api.steamapis.com/image/item/730/#{uri_encoded_market_hash_name}"

  def market_hash_name(wear: true, sttrk_souv: true, knife_prefix: true)
    s = ""
    s += "★ " if knife? && knife_prefix
    s += "Souvenir " if souvenir? && sttrk_souv
    s += "StatTrak™ " if stattrak? && sttrk_souv
    s += name
    s += " (#{wear_name_full})" unless no_wear? || !wear
    s
  end

  def self.float_range(wear)
    {
      factory_new: 0..0.07,
      minimal_wear: 0.07..0.15,
      field_tested: 0.15..0.38,
      well_worn: 0.38..0.7,
      battle_scarred: 0.7..1.0
    }[wear.to_sym]
  end

  def float_range
    return nil if no_wear?

    {
      factory_new: 0..0.07,
      minimal_wear: 0.07..0.15,
      field_tested: 0.15..0.38,
      well_worn: 0.38..0.7,
      battle_scarred: 0.7..1.0
    }[wear.to_sym]
  end

  def wear_name_full
    {
      no_wear: "",
      factory_new: "Factory New",
      minimal_wear: "Minimal Wear",
      field_tested: "Field-Tested",
      well_worn: "Well-Worn",
      battle_scarred: "Battle-Scarred"
    }[wear.to_sym]
  end

  def wear_name_compact
    {
      no_wear: "",
      factory_new: "FN",
      minimal_wear: "MW",
      field_tested: "FT",
      well_worn: "WW",
      battle_scarred: "BS"
    }[wear.to_sym]
  end

  def uri_encoded_market_hash_name = URI.encode_uri_component(market_hash_name)

  private

  def stattrak_and_souvenir_are_mutually_exclusive
    if stattrak? && souvenir?
      errors.add(:base, "Item cannot be both StatTrak and Souvenir")
    end
  end
end
