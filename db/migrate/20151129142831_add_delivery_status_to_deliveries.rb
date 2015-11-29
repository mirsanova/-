class AddDeliveryStatusToDeliveries < ActiveRecord::Migration
  def change
    add_column :deliveries, :delivery_status, :boolean, default: false
  end
end
