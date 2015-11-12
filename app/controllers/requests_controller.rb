class RequestsController < ApplicationController
  require 'open-uri'

  def show

     @request = Request.new(params)


    flash[:error] = ""
    @locations = Emspost::Request.get_locations()
    @max_weight = Emspost::Request.get_max_weight()

    @request.max_weight = @max_weight.to_f
    if @request.valid?
        puts "good"
    else
      puts "erroer"
    end


    if params[:from_location].nil? && params[:to_location].nil?
      puts 'error!'
    else
      if params[:weight].blank?
          flash[:error] = "Вес не должен быть пустым"
          render 'show'

      elsif !params[:weight].blank? && params[:weight].to_f > @max_weight.to_f
          flash[:error] = "Вес не должен быть больше максимального"
          render 'show'

      else
        flash[:error] = ""
        res = Emspost::Request.calculate(params[:from_location], params[:to_location], params[:weight])

        if !res.nil?
          @result_price = res['price']
            @result_term_min = res['term']['min']
            @result_term_max = res['term']['max']
          else
              flash[:error] = "Запрос не выполнен"
          end
      end
    end
  end

  def new
    @request = Request.new(params)
  end

end