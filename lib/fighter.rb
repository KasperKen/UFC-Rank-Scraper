#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class Fighter

  extend Findable
  include Tools

  @@all = []


  attr_accessor :record, :bio_link
  attr_reader :name, :weightclass

  def initialize(name, record, bio_link)
    @name = name
    @record = record
    @bio_link = bio_link
    self.save
  end
  
  
  def save
    @@all << self
  end


  def self.all
    @@all
  end


  def rank
    Rank.all.select {|rank| rank.fighter.name == self.name}
  end

  def display_ranks
    rank.map {|object| ("ranked #{object.rank} in the #{object.weightclass.name} division")}
  end

  def bio_scrape
    Scraper.all[0].get_page(@bio_link) 
  end


  def bio_summery
   "\n" + self.bio_scrape.css('div .content').css('p')[0].text 
  end


  def full_bio
    self.bio_scrape.css('div .content').text.gsub(/\n/, "\n\n").gsub('(adsbygoogle = window.adsbygoogle || []).push({});', "")
  end


  def weightclass
    self.rank.map {|element| element.weightclass}
  end 
  

  def self.valid_fighter?(name)
    invalid_array = ["Ineligible for Rankings\n* Suspension\n* Inactivity>15 months\n* Moving Divisions\n* Yet to debut"]

    name != '' && !invalid_array.include?(name)
  end
 

end
