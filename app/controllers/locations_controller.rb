

class LocationsController < ApplicationController
    def home
        end
    
    def search
        if params[:location]==""
            flash[:error]="Geopedia needs input!"
            
            redirect_to root_path
            return
        elsif params.has_key?(:location)
                new_location=Location.new(params[:location])
                if new_location.tag=="none"
                    flash[:error]="Oops! You just entered an unknown place."
                    redirect_to root_path
                    return
                elsif new_location.tag=="multiple"
                    session[:location]=new_location
                    flash[:notice]="We have multiple results for you"
                    redirect_to root_path
                    return
                else
                    session[:location]=new_location
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

  def place_dining
  end
  
  def place_shopping
  end
  def place_hiking
  end
  def place_lodging
  end

  def weather
  end
end
