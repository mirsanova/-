class Category < ActiveRecord::Base

  has_many :deliveries, dependent: :destroy

  scope :sortered, -> { order(description: :asc) }

  def self.search(search)
    if search
      where('lower(description) LIKE ?', "%#{search.downcase}%").order("description DESC")  
    else
      order("description DESC")  
    end
  end 

  def filtered_description
    descriptions.include?(description) ? '***' : description
  end 

  protected

  def descriptions
    descriptions ||= Filter::Words.load()
  end

end