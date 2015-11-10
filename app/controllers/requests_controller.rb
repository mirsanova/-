class RequestsController < ApplicationController
  require 'open-uri'
  	def create
    
    	
    	
  	end
  

  def show
    get_locations
    get_max_weight
    
    if params[:from_location].nil? && params[:to_location].nil?
    	puts 'error!'
    	
    	
    	
    	
    	    	
    else	
    	if params[:weight] > @max_weight
    		puts 'error!'
    		flash.now[:error] = 'Thank you for your message.'
    		
    		    		
    	else
    		calculate
    	end	
    end
  end
  def new
  	@request = Request.new
  end
  def get_locations
    response = open('http://emspost.ru/api/rest/?method=ems.get.locations&type=russia&plain=true').read
    result = JSON.parse(response)
    res = result['rsp']['locations']
    @locations = Hash.new
    
    res.each do |loc|
    	@locations[loc['value']] = loc['name'].mb_chars.capitalize.to_s   
    end
  end
  def get_max_weight
  	response = open('http://emspost.ru/api/rest/?method=ems.get.max.weight').read
  	result = JSON.parse(response)
    @max_weight = result['rsp']['max_weight']

  end
  def calculate
  	response = open("http://emspost.ru/api/rest?method=ems.calculate&from=#{params[:from_location]}&to=#{params[:to_location]}&weight=#{params[:weight]}").read
    @result = JSON.parse(response)
    if @result['rsp']['stat'] == 'ok'
    	@result_price = @result['rsp']['price']
    	@result_term_min = @result['rsp']['term']['min']
		@result_term_max = @result['rsp']['term']['max']
	else
		puts 'error!'
	end		
  end

end