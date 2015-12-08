class DeliveriesController < ApplicationController
  before_action :must_login, only: [:show, :new, :create, :update]

  include ApplicationHelper
  require 'open-uri'
    before_action :locations_all

  def index
    @deliveries = Delivery.all
    @categories = Category.sortered   
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

  def update 
    
    @category = Category.find(params[:category_id])
    @category.update_attributes(:description => params[:description])
    respond_to do |format|
        format.html
        format.json { render :json => { :id => @category.id, :description => @category.description }}
    end
    
    
  end
  def update_status
    @delivery = Delivery.find(params[:id])
    @delivery.update_attributes(:delivery_status => params[:delivery_status])
    category = Category.find(params[:category_id])
    
     respond_to do |format|
        format.html
        format.json { render :json => category.deliveries.status_desc }
    end
  end


  def search
    @categories = Category.search(params[:search])    
   
    categories = get_categories_hash
   
    respond_to do |format|
        format.html
        format.json { render :json => categories }
    end
  end

  def delete_category

    category = Category.find(params[:category_id])
    category.destroy

    @categories = Category.all 

    categories = get_categories_hash

    respond_to do |format|
      format.html
      format.json { render :json => categories}
    end
   
  end


  def get_categories_hash

    categories = [] 
    @categories.each do |cat| 
      categories << { 
        id: cat.id, 
        description: cat.filtered_description, 
        link: edit_category_path(cat) 
      } 
      end 
    categories
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

      if params[:weight].to_f > category.max_weight || params[:weight].to_f < category.min_weight
        err_msg = "Для категории #{category.description} вес не должен превышать #{category.max_weight} кг и не должен быть менее #{category.min_weight} кг."
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
      params.require(:delivery).permit(:from_location, :to_location, :weight, :price, :term_min, :term_max, :category_id, :status)
    end
end
