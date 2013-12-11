require 'rubygems'
require 'open-uri'
require 'json'

module Api
    module V1

class LocationsController < ApplicationController
    
    respond_to :json
    def search
        if params.has_key?(:location)
            google_url='http://maps.googleapis.com/maps/api/geocode/json?'
            hash={:address =>params[:location], :sensor=>false}
            url=URI.escape(hash.to_a.collect {|each| each.join('=')}.join('&'))
            result=open(google_url+url).read
            geo_results=JSON.parse(open(google_url+url).read)["results"]
            longitude=geo_results[0]["geometry"]["location"]["lng"].to_s
            latitude=geo_results[0]["geometry"]["location"]["lat"].to_s
            place_url='https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            match={:location =>latitude+","+longitude, :radius=>10000, :sensor=>false, :key=>'AIzaSyCnBGnZOGCUM-mbtHKY20KUW6xmbKr0ewY', :types=>"cafe|restaurant"}
      if params.has_key?(:type)
          
        if params[:type]=="geo"
            
        
        elsif params[:type]=="dining_place"
        
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            result=open(place_url+url).read
        elsif params[:type]=="hiking_place"
            match[:types]="park|campground"
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            result=open(place_url+url).read
        
        elsif params[:type]=="lodging_place"
            match[:types]="lodging"
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            result=open(place_url+url).read
        
        elsif params[:type]=="shopping_place"
            match[:types]="grocery_or_supermarket|florist|store|liquor_store"
            url=URI.escape(match.to_a.collect {|each| each.join('=')}.join('&'))
            result=open(place_url+url).read
        
        elsif params[:type]=="weather"
            weather_url='http://api.wunderground.com/api/cd4162f7975b8de1/forecast/q/'
            url=URI.escape(weather_url+latitude+","+longitude+'.json')
            result=open(url).read
        else
            result={:results=>[],:status=>"Wrong Type or Location"}

        end
     else
     
     
        end
    else
        result={:results=>[],:status=>"Missing Location"}
        
    end
    respond_with result
    end

 end
end
end
