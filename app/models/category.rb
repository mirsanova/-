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
    # descriptions.include?(description) ? '***' : description
    if descriptions.any? { |d| desc = description.mb_chars.downcase!; d = d.mb_chars.downcase!.to_s; desc[d]}
      descriptions.each do |d|

        d = d.mb_chars.downcase!
        
        count = d.length
        string = '*' * count


        desc = description.mb_chars.downcase!
              
        desc.gsub!(/#{d}/, string)       
      end      
    end
    description
  end 

  protected

  def descriptions
    descriptions ||= Filter::Words.load()
  end

end