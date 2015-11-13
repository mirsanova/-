class RequestController < ApplicationController
  require 'open-uri'
  def index
    @locations = Emspost::Request.get_locations()
  end
end
