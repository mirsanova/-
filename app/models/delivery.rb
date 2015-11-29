class Delivery < ActiveRecord::Base
  belongs_to :category
  validates :from_location, presence: true
  validates :to_location, presence: true
  validates :category, presence: true
  validates :weight, presence: true
  validates :price, presence: true
  validates :term_min, presence: true
  validates :term_max, presence: true

scope :status_desc, -> { order('delivery_status DESC') }

end
