module Filter
  class Words
  	require 'csv'  	
    def self.load          	
    	csv_text = File.read('tmp/words.csv')
    	csv = CSV.parse(csv_text)
    	arr = []    	
        csv.each do |row|
        	arr << row[0]
		end		
		arr				
    end
    
  end
end