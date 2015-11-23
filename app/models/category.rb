class Category < ActiveRecord::Base
  has_many :deliveries, dependent: :destroy

  def self.search(search)
    if search
      where('description LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end   
end