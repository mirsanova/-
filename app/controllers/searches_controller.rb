class SearchesController < ApplicationController
  require 'open-uri'

  def show
    @search = Search.new
    @locations = Emspost::Request.get_locations()
  end


  def new
      @search = Search.new
  end

  def calculate_ems
    max_weight = Emspost::Request.get_max_weight()

    result_price = ""
    result_term_min = ""
    result_term_max = ""

    if params[:weight].blank?
      err_msg = "Вес не должен быть пустым"
    elsif !params[:weight].blank? && params[:weight].to_f > max_weight.to_f
      err_msg = "Вес не должен быть больше максимального, максимальный вес - #{max_weight}"
    else
      res = Emspost::Request.calculate(params[:from_location], params[:to_location], params[:weight])

      if !res.nil?
        result_price = res['price']
        result_term_min = res['term']['min']
        result_term_max = res['term']['max']
      else
        err_msg = "Запрос не выполнен"
      end
    end

    respond_to do |format|
      format.html
      if err_msg.nil?
        format.json { render :json => { :price => result_price, :term_min => result_term_min, :term_max => result_term_max }, status: 200 }
      else
        format.json { render :json => { :text => err_msg }, status: 400 }
      end

    end
  end
end
