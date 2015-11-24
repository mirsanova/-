class Category < ActiveRecord::Base
  has_many :deliveries, dependent: :destroy

  scope :sortered, -> { order(description: :asc) }

  def self.search(search)
    if search
      where('lower(description) LIKE ?', "%#{search.downcase}%").order("description DESC")  
    else
      where(nil).order("description DESC")  
    end
  end  


end