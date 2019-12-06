require 'nokogiri'
require 'open-uri'

class Scraper


  def self.create
   new
  end


  def iterate 
    url = ("http://rankingmma.com/ufc-rankings")

    url_list = [
      ("#{url}/heavyweight"),
      ("#{url}/light-heavyweight"),
      ("#{url}/middleweight"),
      ("#{url}/lightweight")
    ]

    url_list.each {|url| scrape(url)}
  end


  def start
    self.iterate
  end


  def get_page(url)
    Nokogiri::HTML(open(url))
  end


  def scrape(url)
    doc = get_page(url)
    row = doc.css('table')[0].css('tbody').css('tr')


    row.each do |data|
      fighter_name = data.children[4].text.chomp

      fighter_data = {
        :ranking => data.children[1].text,
        :record => data.children[5].text,
        :weight_class => doc.css('h1').text.gsub('UFC ', '').gsub(' Rankings', '').strip
      }
  
      self.create_fighter(fighter_name, fighter_data) unless fighter_data[:ranking] == ''
    end
  end


  def create_fighter(fighter_name, fighter_data)
    fighter = Fighter.create(fighter_name)
    fighter.add_attributes(fighter_data)
  end
 

end
