require 'rubygems'
require 'open-uri'
require 'json'
class Location < ActiveRecord::Base
    attr_accessor :location, :longitude, :latitude, :city, :state, :country,:tag,:places
    def initialize(location='berkeley ca', mul=false)
        google_url='http://maps.googleapis.com/maps/api/geocode/json?'
        match={:address =>location, :sensor=>false}
        url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
        results=''
        geo_results=JSON.parse(open(google_url+url).read)["results"]
        if geo_results.length==1 || (geo_results.length>1 && mul)
            
            @location=geo_results[0]["formatted_address"]
            @longitude=geo_results[0]["geometry"]["location"]["lng"].to_s
            @latitude=geo_results[0]["geometry"]["location"]["lat"].to_s
            newmatch={:latlng=>@latitude+","+@longitude, :sensor=>false}
            newurl=URI.escape(newmatch.to_a.collect {|each| each.join('=')}.join('&'))
            newresults=''
            newresults=JSON.parse(open(google_url+newurl).read)["results"]
            if newresults.length>0 and newresults[0]["address_components"].length>0
            newresults[0]["address_components"].each do |i|
                i["types"].each do |j|
                    if j=="locality"
                        @city=i["long_name"]
                    elsif j=="administrative_area_level_2" && @city==nil
                        @city=i["long_name"]
                    elsif j=="administrative_area_level_1"
                        @state=i["long_name"]
                    elsif j=="country"
                        @country=i["long_name"]
                    
                    end
                end
            end
            else
            @tag="missing_address"
            end
        elsif geo_results.length >1
            @tag="multiple"
            @places=[]
            geo_results.each do |result|
                @places.push(Location.new(result["geometry"]["location"]["lat"].to_s+","+result["geometry"]["location"]["lng"].to_s, true))
            end
                        
        else
            @tag="none"
        end
    end

        def get_info
            wiki_url='http://en.wikipedia.org/w/api.php?'
            hash={:format =>"json", :action=>"query", :list=>"search", :srsearch=>@city+", "+@state}
            url=URI.escape(hash.to_a.collect {|each| each.join('=')}.join('&'))
            info_results=JSON.parse(open(wiki_url+url).read)["query"]["search"]
            return info_results
        end
        
        def get_weather
            weather_url='http://api.wunderground.com/api/cd4162f7975b8de1/forecast/q/'
            url=URI.escape(weather_url+@latitude+","+@longitude+'.json')
            weather_results=JSON.parse(open(url).read)["forecast"]["txt_forecast"]["forecastday"]
            return weather_results
            end
        def get_place_dining
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>@latitude+","+@longitude, :radius=>10000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY', :types=>"cafe|restaurant"}
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            place_results=JSON.parse(open(place_url+url).read)["results"]
            end
        def get_place_hiking
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>@latitude+","+@longitude, :radius=>10000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY', :types=>"park|campground"}
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            place_results=JSON.parse(open(place_url+url).read)["results"]
        end
        def get_place_shopping
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>@latitude+","+@longitude, :radius=>10000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY',:types=>"grocery_or_supermarket|florist|store|liquor_store"}
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            place_results=JSON.parse(open(place_url+url).read)["results"]
        end
        def get_place_lodging
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>@latitude+","+@longitude, :radius=>10000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY',:types=>"lodging"}
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            place_results=JSON.parse(open(place_url+url).read)["results"]
        end
    
end
