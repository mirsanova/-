class ApiController2 < ApplicationController
  def calculate_ems
    require 'open-uri'

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
      format.json { render :json => { :err_msg => err_msg, :price => result_price, :term_min => result_term_min, :term_max => result_term_max } }
    end
  end
end
