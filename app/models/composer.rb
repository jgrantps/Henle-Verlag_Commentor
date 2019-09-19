require "open-uri"
require_relative './concerns/slugify.rb'

class Composer < ActiveRecord::Base

  belongs_to :initial
  has_many :works
  has_many :subcategories, through: :works
  has_many :categories, through: :subcategories
  has_many :favorited_works, through: :works
  has_many :favorites, through: :favorited_works
  has_many :users, through: :favorites

  include Concerns::InstanceMethods
  extend Concerns::ClassMethods
  extend ActiveModel::Callbacks

  after_create :scrape_page

   def scrape_page

    #  binding.pry
     site = self.url
     page = Nokogiri::HTML(open(site))
     albums = page.css("div.result-column-left.clearfix")

     albums.each do |album|
       showpage_link = album.css("figure.result-cover a").attribute("href").value
       image_link = album.css("figure.result-cover a img").attribute("data-src").value
       title = album.css("h2.main-title").text.strip
       composer = album.css("h2.sub-title").text.strip

       album.css("ul.breadcrumb").each do |breadcrumb|
         category = breadcrumb.css("li")[0].text
         subcategory = breadcrumb.css("li")[1].text
# binding.pry
         @work_category = Category.find_or_create_by(:name => category)
# binding.pry
         @work_subcategory = Subcategory.find_or_create_by(:name => subcategory, :category_id => Category.last.id)
# binding.pry
         Work.find_or_create_by(:name => title, :image_url => "https://www.henle.de#{image_link}", :link_url => "https://www.henle.de#{showpage_link}", :composer_id => self.id, :subcategory_id => @work_subcategory.id)
       end
     end
   end
end
