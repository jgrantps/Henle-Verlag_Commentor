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

  site = "https://www.henle.de/us/search/?Composers=#{self[:initial]}"
  page = Nokogiri::HTML(open(site))
  page.css("h2.section-header span").each {|element| composers<<element.text}

  add_to_db(composers)
 end

  def add_to_db(composers)
    composers.each do |composer|
      last_first = composer.insert(-1, ",").split(" ").rotate(-1).join(" ")
      composer_formatted = URI.parse "#{URI.encode(last_first)}"
      url = "https://www.henle.de/en/search/?Composers="+"#{composer_formatted}"
      Composer.find_or_create_by(:name => composer, :url => url, :initial_id => self[:id] )
      binding.pry
    end

  end

end
