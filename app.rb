require 'sinatra'
require "sinatra/reloader"
require "pry"
require "restcountry"
require_relative "./event"
require_relative "./country_adapter"
require_relative "./coronavirus_adapter"
require_relative "./coronavirus"

post "/v1/risk" do
    request.body.rewind
    params = JSON.parse(request.body.read)

    country = Restcountry::Country.find_by_name(params["country"])
    covid19_latest_data = PomberCovid19.find_by_region_name(params["country"]).last

    event = Event.new(
        population: country.population, 
        carriers: covid19_latest_data["confirmed"], 
        group_size: params["groupSize"].to_i
    )

    content_type :json
    { risk: event.risk }.to_json
end
