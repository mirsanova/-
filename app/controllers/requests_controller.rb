class RequestsController < ApplicationController
  require 'open-uri'


  def show
  	# response = open('http://emspost.ru/api/rest?method=ems.calculate&from=city--moskva&to=region--omskaja-oblast&weight=1.5').read
  	# result = JSON.parse(response)

  	# @result_msg = result['rsp']
  	# @result_stat = result['rsp']['stat']
  	# @result_price = result['rsp']['price']
  	# @result_term_min = result['rsp']['term']['min']
  	# @result_term_max = result['rsp']['term']['max']

    get_locations
    get_max_weight

    if params[:weight].blank?
      flash[:error] = "Вес не должен быть пустым"
      render 'show'
    end

    if !params[:weight].blank? && params[:weight] > @max_weight
      flash[:error] = "Вес не должен быть больше максимального"
      render 'show'
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
      @locations[loc['value']] = loc['name']
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
    puts "------!!!!!-------!!!!!!------"
    puts @result
  end
end
