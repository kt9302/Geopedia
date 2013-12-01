require 'spec_helper'

describe LocationsController do

  describe "GET 'info'" do
    it "returns http success" do
      get 'info'
      response.should be_success
    end
  end

  describe "GET 'map'" do
    it "returns http success" do
      get 'map'
      response.should be_success
    end
  end

  describe "GET 'point_of_interest'" do
    it "returns http success" do
      get 'point_of_interest'
      response.should be_success
    end
  end

  describe "GET 'weather'" do
    it "returns http success" do
      get 'weather'
      response.should be_success
    end
  end

end
