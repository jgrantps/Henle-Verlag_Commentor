require "open-uri"
class Alphabetized #< ActiveRecord::Base

attr_reader :initial

@@all = []

 def initialize(initial)
  @initial = initial
  @@all<<@initial
    if !self.class.all.include?(initial)
      scrape_page
    end
 end

 def self.all
   @@all
 end

 def scrape_page
   composers = []
  site = "https://www.henle.de/us/search/?Composers=#{@initial}"
  page = Nokogiri::HTML(open(site))
  composer_list = []

    page.css("form.form-sort select.select-sort option").each {|element| composers<<element.text}
    composers.select do |t|
      if !(t.include?("Sort by composer")||t.include?("Sort by scoring")||t.include?("Sort by price")||t.include?("All composers"))
        composer_list<<t
      end
    end
    add_to_db(composer_list)
  end

  def add_to_db(composer_list)
    composer_list.each do |composer|
      url = "https://www.henle.de/en/search/?Composers="+composer.gsub(" ", "+")
      Composer.create(:name => composer, :composer_url => url)
    end
  end
end
