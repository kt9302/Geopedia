require 'open-uri'
require JSON

url = URI.parse('http://maps.googleapis.com/maps/api/geocode/json?address=berkeley%20,%20%20CA&sensor=false')
open(url) do |http|
    response = http.read
    hash=JSON.parse(response)
    puts hash
end
