class DeliveriesController < ApplicationController
	before_action :locations_all
	def new
    	@deliveries = Delivery.new
    	@locations = Hash.new
    	@categories = Hash.new
  	end
  	def locations_all
    	@locations_all = Emspost::Request.get_locations()
	end

end