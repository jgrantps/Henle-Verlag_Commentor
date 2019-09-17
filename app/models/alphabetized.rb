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

 def scrape_page
  site = "https://www.henle.de/us/search/?Composers=#{@initial}"
  @page = Nokogiri::HTML(open(site))
  @composers = []
  @composer_list = []

    @page.css("form.form-sort select.select-sort option").each {|element| @composers<<element.text}  
    @composers.select do |t|
      if !(t.include?("Sort by composer")||t.include?("Sort by scoring")||t.include?("Sort by price")||t.include?("All composers"))
        @composer_list<<t
      end
    end
    @composer_list
  end

  def composer_urls
    composer_url = []
    @composer_list.each {|composer| composer_url << "https://www.henle.de/en/search/?Composers="+composer.gsub(" ", "+")}
    composer_url
    binding.pry
  end
end