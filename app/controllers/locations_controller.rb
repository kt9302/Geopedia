

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
                    session[:location]=Location.new('berkeley ca')
                    redirect_to root_path
                    return
                elsif new_location.tag=="multiple"
                    ps=new_location.places
                    session[:location]=Location.new('berkeley ca')
                    session[:location].places=ps
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

  

  def place_dining
      if session[:location].city==nil
          session[:location]=Location.new('berkeley ca')
      end
  end
  
  def place_shopping
      if session[:location].city==nil
          session[:location]=Location.new('berkeley ca')
      end
  end
  def place_hiking
      if session[:location].city==nil
          session[:location]=Location.new('berkeley ca')
      end
  end
  def place_lodging
  end

  def weather
      if session[:location].city==nil
          session[:location]=Location.new('berkeley ca')
      end
  end
end
