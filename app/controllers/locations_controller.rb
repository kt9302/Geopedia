

class LocationsController < ApplicationController
    def home
        end
    
    def search
        if params[:location]==""
            flash[:error]="Geopedia needs input!"
            
            redirect_to root_path
            return
            elsif params.has_key?(:location)
            if Location.new(params[:location]).location=="none"
                flash[:error]="Oops!This place is not on earth."
                redirect_to root_path
                return
                elsif Location.new(params[:location]).location=="multiple"
                flash[:notice]="We have multiple results for you"
                redirect_to root_path
                return
                else
                session[:location]=Location.new(params[:location])
            end
            else
            session[:location]=Location.new('berkeley ca')
        end
        
        render '/app/views/locations/info.html.erb'
        end
        
  def info
      
  end

  def map
  end

  def point_of_interest
  end

  def weather
  end
end
