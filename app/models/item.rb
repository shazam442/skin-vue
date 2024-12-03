class Item < ApplicationRecord
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

  def img_url = "https://api.steamapis.com/image/item/730/#{uri_encoded_market_hash_name}"

  def market_hash_name
    s = ""
    s += "★ " if knife?
    s += "Souvenir " if souvenir?
    s += "StatTrak™ " if stattrak?
    s += name
    s += " (#{wear_name_full})" unless no_wear?
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
end
