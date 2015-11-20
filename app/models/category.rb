class Category < ActiveRecord::Base
  has_many :deliveries, dependent: :destroy
end



