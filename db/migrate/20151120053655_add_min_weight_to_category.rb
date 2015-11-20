class AddMinWeightToCategory < ActiveRecord::Migration
  def change
  	add_column :categories, :min_weight, :decimal
  end
end
