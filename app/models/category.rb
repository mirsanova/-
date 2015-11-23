class Category < ActiveRecord::Base
  has_many :deliveries, dependent: :destroy

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      Category.all
    end
  end   
end