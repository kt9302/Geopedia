require 'rubygems'
require 'open-uri'
require 'json'
class Location < ActiveRecord::Base
    attr_accessor :location, :longitude, :latitude, :city, :state, :country
    def initialize(location='berkeley ca')
        google_url='http://maps.googleapis.com/maps/api/geocode/json?'
        match={:address =>location, :sensor=>false}
        url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
        results=''
        results=JSON.parse(open(google_url+url).read)["results"]
        if results.length>=1
            @location=results[0]["formatted_address"]
            @longitude=results[0]["geometry"]["location"]["lng"].to_s
            @latitude=results[0]["geometry"]["location"]["lat"].to_s
            newmatch={:latlng=>@latitude+","+@longitude, :sensor=>false}
            newurl=URI.escape(newmatch.to_a.collect {|each| each.join('=')}.join('&'))
            newresults=''
            newresults=JSON.parse(open(google_url+newurl).read)["results"][0]
            newresults["address_components"].each do |i|
                i["types"].each do |j|
                    if j=="locality"
                        @city=i["long_name"]
                    elsif j=="administrative_area_level_1"
                        @state=i["long_name"]
                    elsif j=="country"
                        @country=i["long_name"]
                    
                    end
                end
            
            end
        elsif results.length>1
            @location="multiple"
        
        else
            @location="none"
        end
    end

        def get_info
            wiki_url='http://en.wikipedia.org/w/api.php?'
            hash={:format =>"json", :action=>"query", :list=>"search", :srsearch=>@city+", "+@state}
            url=URI.escape(hash.to_a.collect {|each| each.join('=')}.join('&'))
            results=JSON.parse(open(wiki_url+url).read)["query"]["search"]
            return results
        end
        
        def get_weather
            weather_url='http://api.wunderground.com/api/cd4162f7975b8de1/forecast/q/'
            url=URI.escape(weather_url+@latitude+","+@longitude+'.json')
            newresults=JSON.parse(open(url).read)["forecast"]["txt_forecast"]["forecastday"]
            return newresults
            end
        def get_place
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>@latitude+","+@longitude, :radius=>1000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY'}
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            results=JSON.parse(open(place_url+url).read)["results"]
            end
    
end
