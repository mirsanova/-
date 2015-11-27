class AddStatusToDeliveries < ActiveRecord::Migration
  def change
  	add_column :deliveries, :status, :string
  end
end
