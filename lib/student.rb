require "pry"
class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(name:, location:)
    @name = name 
    @location  = location
    @@all << self
  end

  def self.create_from_collection(array)
    array.each do|hash|
    new(hash) 
    end 
  end

  def add_student_attributes(hash)
    hash.each{|key,value| self.send("#{key}=",value)} 
  end


  def self.all
    @@all
  end

end


