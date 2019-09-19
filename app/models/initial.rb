require "open-uri"
class Initial < ActiveRecord::Base
validates :initial, :presence => true
validates :initial, :length => {:maximum => 1}
validates :initial, format: { with: /(^[a-zA-Z]\b$)/,
  message: "is to only be the first letter of a composers last name" }


has_many :composers

extend ActiveModel::Callbacks
after_create :scrape_page

 def scrape_page
  composers = []
  composer_list = []
  site = "https://www.henle.de/us/search/?Composers=#{self[:initial]}"
  page = Nokogiri::HTML(open(site))
  page.css("form.form-sort select.select-sort option").each {|element| composers<<element.text}

  composers.select do |t|
    if !(t.include?("Sort by composer")||t.include?("Sort by scoring")||t.include?("Sort by price")||t.include?("All composers"))
      composer_list<<t
    end
  end
  add_to_db(composer_list)
 end

  def add_to_db(composer_list)
    composer_list.each do |composer_original_format|
      composer = URI.parse "#{URI.encode(composer_original_format)}"
      # binding.pry
      # url = URI.parse "example.com/city/#{URI.encode('"https://www.henle.de/en/search/?Composers="+composer.gsub(" ", "+")')}"
      url = "https://www.henle.de/en/search/?Composers="+"#{composer}"#.gsub(" ", "+")
      Composer.find_or_create_by(:name => composer_original_format, :url => url, :initial_id => self[:id] )
    end

  end

end
