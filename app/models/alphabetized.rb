require "open-uri"
class Alphabetized #< ActiveRecord::Base

attr_reader :initial

@@all = []

 def initialize(initial)
  @initial = initial
  @@all<<@initial
 end

 def self.all
   @@all 
 end 

  site = "https://www.henle.de/us/search/?Composers=#{@initial}"
  page = Nokogiri::HTML(open(site))
  composers = []
  @composer_list = []
  @composer_url = []

  page.css("form.form-sort select.select-sort option").each {|t| composers<<t.text}

  composers.select do |t|
    if !(t.include?("Sort by composer")||t.include?("Sort by scoring")||t.include?("Sort by price")||t.include?("All composers"))
      @composer_list<<t
    end
  end

  @composer_list.each {|composer| @composer_url << "https://www.henle.de/en/search/?Composers="+composer.gsub(" ", "+")}
  binding.pry
end
