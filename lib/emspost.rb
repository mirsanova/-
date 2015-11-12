module Emspost
  class Request
    def self.calculate(from_location, to_location, weight)
      response = open("http://emspost.ru/api/rest?method=ems.calculate&from=#{from_location}&to=#{to_location}&weight=#{weight}").read
      result = JSON.parse(response)

      if result['rsp']['stat'] == 'ok'
        result['rsp']
      else
        puts 'error!'
      end
    end

    def self.get_locations
      response = open('http://emspost.ru/api/rest/?method=ems.get.locations&type=russia&plain=true').read
      result = JSON.parse(response)
      res = result['rsp']['locations']
      locations = Hash.new

      res.each do |loc|
        locations[loc['value']] = loc['name'].mb_chars.capitalize.to_s
      end

      locations
    end

    def self.get_max_weight
      response = open('http://emspost.ru/api/rest/?method=ems.get.max.weight').read
      result = JSON.parse(response)
      max_weight = result['rsp']['max_weight']
    end
  end
end