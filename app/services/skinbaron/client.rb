
module Skinbaron
class Client
  BASE_API_URL = "https://api.skinbaron.de/"

  def dev
    search
  end

  def search
    url = "#{BASE_API_URL}Search"

    req_body = base_body

    res = nil

    ApiRequest.create do |ar|
      ar.target = Market.find_by(name: "skinbaron")
      ar.target_url = url
      ar.request_body = req_body
      res = HTTParty.post(url, headers: headers, body: req_body.to_json)
      ar.success = res.success?
      ar.response_code = res.code
      ar.response_body = res.body
      ar.save
    end

    res.body
  end

  private

  def base_body
    {
      "apikey": Rails.application.credentials.skinbaron_api_key,
      "appid": 730,
      "search_item": "AK-47 | Redline"
    }
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Accept" => "application/json",
      "X-Requested-With" => "XMLHttpRequest"
    }
  end

  def write_to_file(data)
    File.open("./app/services/skinbaron/skinbaron.json", "w") do |f|
      f.write data
    end
  end
end
end
