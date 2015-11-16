class Category < ActiveRecord::Base
  has_many :deliveries
end
