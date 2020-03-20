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
    coronavirus_adapter = CoronavirusAdapter.new(country.alpha2Code)

    coronavirus = Coronavirus.new(coronavirus_adapter)

    event = Event.new(
        population: country.population, 
        carriers: coronavirus.infected, 
        group_size: params["groupSize"].to_i
    )

    content_type :json
    { risk: event.risk }.to_json
end
