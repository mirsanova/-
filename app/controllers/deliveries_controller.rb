class DeliveriesController < ApplicationController
  require 'open-uri'
    before_action :locations_all

  def index
    @deliveries = Delivery.all
    @categories = Category.all


    @categories = Category.search(params[:search])


  end

  def show
    @delivery = Delivery.find(params[:id])
    @category = @delivery.category
  
  end

  def new
    @delivery  = Delivery.new
    @locations = Hash.new
    @categories = Hash.new
  end

  def create
    @delivery = Delivery.new(delivery_params)

    if @delivery.save
      redirect_to @delivery
    else
      render 'new'
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy

    redirect_to deliveries_path
  end

  def locations_all
    @locations_all ||= Emspost::Request.get_locations()
  end

  def calculate_ems
    max_weight ||= Emspost::Request.get_max_weight()

    result_price = ""
    result_term_min = ""
    result_term_max = ""

    if params[:weight].blank?
      err_msg = "Вес не должен быть пустым"
    elsif !params[:weight].blank? && params[:weight].to_f > max_weight.to_f
      err_msg = "Вес не должен быть больше максимального, максимальный вес - #{max_weight}"
    else
      category = Category.find(params[:category_id])
      puts category.min_weight
      puts category.weight
      puts params[:weight].to_f
      puts params[:weight].to_f > category.weight
      puts params[:weight].to_f < category.min_weight


      if params[:weight].to_f > category.weight || params[:weight].to_f < category.min_weight
        err_msg = "Для категории #{category.description} вес не должен превышать #{category.weight} кг и не должен быть менее #{category.min_weight} кг."
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
 

  private
    def delivery_params
      params.require(:delivery).permit(:from_location, :to_location, :weight, :price, :term_min, :term_max, :category_id)
    end
end
