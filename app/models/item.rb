class Item < ApplicationRecord
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

  def sync_listings
    Skinbaron::Service.new(self).sync_to_db
  end

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
