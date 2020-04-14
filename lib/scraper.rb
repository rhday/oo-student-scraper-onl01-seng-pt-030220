require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    page = open("https://learn-co-curriculum.github.io/student-scraper-test-page/")
    page = Nokogiri::HTML(page)

    array=[]

    page.css("div.student-card").each_with_index do |info, index| 
      content_hash = {
        name: page.css("div.student-card h4")[index].text, 
        location: page.css("div.student-card p")[index].text,
        profile_url: page.css("div.student-card a")[index].attr("href")
      }
      array << content_hash
    end
    array
    #binding.pry 
  end

  def self.scrape_profile_page(profile_url)
    student_page = open(profile_url)
    student_page = Nokogiri::HTML(student_page)
    links = student_page.css("div.social-icon-container a").map do|node| 
    node.attr("href")
  end
  new_hash = {
    profile_quote: student_page.css("div.profile-quote").text, 
    bio: student_page.css("div.description-holder p").text
  }
student_name = student_page.css("div.vitals-text-container h1").text

  links.each do |a| 
    if a.include?("twitter")
      new_hash[:twitter]= a 
    elsif
      a.include?("linkedin")
      new_hash[:linkedin] = a 
    elsif 
      a.include?("github")
      new_hash[:github] = a 
    elsif
      a.include?(student_name[1..2])
      new_hash[:blog] = a  
    end
  end
  new_hash
  end

end
