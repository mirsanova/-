class AddMaxWeightToCategory < ActiveRecord::Migration
  def change
     add_column :categories, :max_weight, :decimal
  end
end
