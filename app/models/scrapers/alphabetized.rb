
require 'open-uri'

class Alphabetized < ActiveRecord::Base

  def initialize(initial)
    @initial = initial
  end


  site = "https://www.henle.de/us/search/?Composers=#{@initial}"

  page = Nokogiri::HTML(open(site))

  composers = []
  page.css("form.form-sort select.select-sort option").each do |t|
  composers<<t.text
  end

  @composer_list = []
    composers.select do |t|
      if !(t.include?("Sort by composer")||t.include?("Sort by scoring")||t.include?("Sort by price")||t.include?("All composers"))
      @composer_list<<t
      end
    end
  # https://www.henle.de/en/search/?Composers=T&Composer=Tom%C3%A1%C5%A1ek%2C+V%C3%A1clav+Jan
  @composer_url = []
  @composer_list.each do |composer|
    # ary = composer.split(", ").rotate(-1).join(", ").gsub(" ", "+")
    ary = composer.gsub(" ", "+")
    composer_link = "https://www.henle.de/en/search/?Composers="+ary
    @composer_url<<composer_link
    end
    end
