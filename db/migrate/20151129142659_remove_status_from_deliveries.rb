class RemoveStatusFromDeliveries < ActiveRecord::Migration
  def change
    remove_column :deliveries, :status
  end
end
