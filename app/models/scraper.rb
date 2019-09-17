
require 'open-uri'

class Scraper < ActiveRecord::Base

  def initialize(initial)
  site = "https://www.henle.de/us/search/?Composers=#{initial.upcase}"
  page = Nokogiri::HTML(open(site))
  albums = page.css("div.result-column-left.clearfix")

  puts albums.count

  albums.each do |album|
    showpage_link = album.css("figure.result-cover a").attribute("href").value
    image_link = album.css("figure.result-cover a img").attribute("data-src").value
    title = album.css("h2.main-title").text.strip #=> Title for each work
    composer = album.css("h2.sub-title").text.strip

    album.css("ul.breadcrumb").each do |breadcrumb|
      category = breadcrumb.css("li")[0].text
      subcategory = breadcrumb.css("li")[1].text

      puts "Category is: #{category}"
      puts "Subcategory is: #{subcategory}"
      puts "Composer is: #{composer}"
      puts "Title is: #{title}"
      puts "Showpage Link is: https://www.henle.de#{showpage_link}"
      puts "Image URL is: https://www.henle.de#{image_link}"
      puts " "

    end

  end
end
