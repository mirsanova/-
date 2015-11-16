class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :from_location, null: false
      t.string :to_location, null: false
      t.decimal :weight, null: false
      t.integer :price, null: false
      t.integer :term_min, null: false
      t.integer :term_max, null: false
      t.belongs_to :category, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
