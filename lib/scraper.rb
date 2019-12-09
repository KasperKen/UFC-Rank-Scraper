require 'nokogiri'
require 'open-uri'

class Scraper

  @@all = []
  

  def initialize
    self.save
  end


  def save
    @@all << self
  end


  def self.all
    @@all
  end


  def url_list 
    url = ("http://rankingmma.com/ufc-rankings")

    [
      ("#{url}/heavyweight"),
      ("#{url}/light-heavyweight"),
      ("#{url}/middleweight"),
      ("#{url}/featherweight"),
      ("#{url}/lightweight"),
      ("#{url}/flyweight"),
      ("#{url}/middleweight"),
      ("#{url}/welterweight"),
      ("#{url}/bantamweight"),
      ("#{url}/womens-bantamweight"),
      ("#{url}/womens-flyweight"),
      ("#{url}/womens-strawweight")
    ]
  end


  def start
    url_list.each {|url| scrape(url)}
  end


  def get_page(url)
    Nokogiri::HTML(open(url))
  end


  def scrape(url)
    doc = get_page(url)
    row = doc.css('table')[0].css('tbody').css('tr')

    weightclass = format_name(doc.css('h1'))
    weight = WeightClass.new(weightclass)

    row.each do |data|
      self.abstract_data(doc, data, weight)
    end
  end


  def format_name(name)
    name = name.text.gsub('UFC ', '').gsub(' Rankings', '').strip
  end


  def abstract_data(doc, data, weight)
    fighter_name = data.children[4].text.gsub('8-5 (2-4 UFC)', '').strip
    bio_link = data.css('a')[0]['href'] if data.css('a')[0]
    ranking = data.children[1].text
    record = data.children[5].text.strip
    self.create_objects(fighter_name, bio_link, ranking, record, weight)
  end


  def create_objects(fighter_name, bio_link, ranking, record, weight)
    if Fighter.valid_fighter?(fighter_name)
      if Fighter.object_exists?(fighter_name)
        fighter = Fighter.find_by_name(fighter_name)
      else 
        fighter = Fighter.new(fighter_name, record, bio_link)
      end
      Rank.new(ranking, fighter, weight)
    end
  end

end
