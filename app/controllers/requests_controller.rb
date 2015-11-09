class RequestsController < ApplicationController	
  def index
    require 'open-uri'
	response = open('http://emspost.ru/api/rest?method=ems.calculate&from=city--moskva&to=region--omskaja-oblast&weight=1.5').read
	result = JSON.parse(response)
	@result_msg = result['rsp']
	@result_stat = result['rsp']['stat']
	@result_price = result['rsp']['price']
	@result_term_min = result['rsp']['term']['min']
	@result_term_max = result['rsp']['term']['max']
  end
  def new
    @request = Request.new
  end
end