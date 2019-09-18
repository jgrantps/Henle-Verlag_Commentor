require "open-uri"
class ComposerInitial < ActiveRecord::Base
has_many :composers

extend ActiveModel::Callbacks
after_initialize :scrape_page

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
    composer_list.each do |composer|
      url = "https://www.henle.de/en/search/?Composers="+composer.gsub(" ", "+")
      Composer.find_or_create_by(:name => composer, :composer_url => url)
    end
  end

end
