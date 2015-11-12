class RequestController < ApplicationController
  def index
    @locations = Emspost::Request.get_locations()
  end
end
