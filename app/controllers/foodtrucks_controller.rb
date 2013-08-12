class FoodtrucksController < ApplicationController
  def show
    trucks = Foodtruck.all
    locations = Location.all
  end
end
