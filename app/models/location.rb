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
        if results.length>0 #and results.length==1
            @location=results[0]["formatted_address"]
            @longitude=results[0]["geometry"]["location"]["lng"]
            @latitude=results[0]["geometry"]["location"]["lat"]
            newmatch={:latlng=>@latitude.to_s+","+@longitude.to_s, :sensor=>false}
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
        else
            @location=""
        end
    end
        
        def get_info
            wiki_url='http://en.wikipedia.org/w/api.php?'
            hash={:format =>"json", :action=>"query", :list=>"search", :srsearch=>@city}
            url=URI.escape(hash.to_a.collect {|each| each.join('=')}.join('&'))
            results=JSON.parse(open(wiki_url+url).read)["query"]["search"]
        end
    
end
