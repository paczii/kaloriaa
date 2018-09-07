require "rails_helper"

RSpec.describe DistancesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/distances").to route_to("distances#index")
    end

    it "routes to #new" do
      expect(:get => "/distances/new").to route_to("distances#new")
    end

    it "routes to #show" do
      expect(:get => "/distances/1").to route_to("distances#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/distances/1/edit").to route_to("distances#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/distances").to route_to("distances#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/distances/1").to route_to("distances#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/distances/1").to route_to("distances#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/distances/1").to route_to("distances#destroy", :id => "1")
    end

  end
end
