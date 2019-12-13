#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class Cli


  def start
    system('clear')
    puts 'Downloading Fighters...'
    puts 'Please wait'
    scraper = Scraper.new
    scraper.start_scrape
    
    self.main_menu
  end


  #-------------------------------CLI PRINTING------------------------------
  

  def print_main_commands
    puts "\n"
    puts "   --------------------------------------------------------------"
    puts "  |                          'Main Menu'                         |"
    puts "  |                         ------------                         |"
    puts "  |                                                              |"
    puts "  |  [1] - List information about fighters                       |"
    puts "  |  [2] - List divisions and their fighters                     |"
    puts "  |  quit or exit: to leave program                              |"
    puts "  |                                                              |"
    puts "   --------------------------------------------------------------"
    puts "\n"
  end


  def print_fighter_commands
    puts "\n"
    puts "   --------------------------------------------------------------"
    puts "  |                           Fighters                           |"
    puts "  |                          ----------                          |"
    puts "  |                                                              |"
    puts "  |  type in a name of a fighter to list information about them  |"
    puts "  |  [back] Go back to main menu                                 |" 
    puts "  |                                                              |"
    puts "   --------------------------------------------------------------"
    puts "\n"
  end

  
  def weightclass_menu_template(input)
    puts "\n"
    puts "   --------------------------------------------------------------"
    puts "  |                         Weightclass                          |"
    puts "  |                        -------------                         |"
    puts "  |                                                              |"
    puts input
    puts "  |                                                              |"
    puts "   --------------------------------------------------------------"
    puts "\n"
  end


  def print_choose_weightclass_menu
    input = [
    "  |  type in a name of a weightclass to list fighters            |\n",
    "  |  [1] List all weightclasses                                  |\n",
    "  |  [back] Go back to main menu                                 |" 
    ]

    self.weightclass_menu_template(input)
  end


  def print_weightclass_main_menu               
    input = [
    "  |  [1] List all Fighters                                       |\n",
    "  |  [2] Search For a fighter                                    |\n",
    "  |  [back] choose another weightclass                           |" 
    ]

    self.weightclass_menu_template(input)
  end 

  
  def print_weightclass_info(weightclass)
    self.weightclass_menu_template(self.weightclass_menu) 
    puts "\n#{weightclass.name}"
    puts "fighters: #{weightclass.fighters.count}"
  end


  def print_not_found(choice)
    puts "#{choice} not found!"
    puts "--------------------------------\n"
  end


  def print_bio_options
    puts "\n| [1] - List Full Bio  | [back] - back to search |\n\n"
  end


  def print_fighter(fighter) 
    puts fighter.name
    puts "Pro MMA record: #{fighter.record}" 
    puts fighter.display_ranks
    puts "\n--------------------------------"
  end

  
  def print_all(choice)

    choice.each_with_index do |element, index| 
      index += 1
      index = index.to_s #<<<<<<<<<<<< Needs refactoring
      index = index.gsub(index, "00#{index}") if index.to_i < 10 
      index = index.gsub(index, "0#{index}") if index.to_i < 100 && index.to_i > 9 
    
       
      puts "#{index}: #{element.name} : Fighters:#{element.fighters.count}" if WeightClass.all.include?(choice[0])
      puts "#{index}: #{element.name} : #{element.weightclass[0].name} - rank: #{element.rank[0].rank}" if Fighter.all.include? choice[0]
    end

    puts "----------------------------------------------------------------------\n"
  end


  #---------------CLI Menus------------------------


  def selection_tool(element, input)  

    if element.count == 0
      self.print_choose_weightclass_menu if WeightClass.all.include?(element[0])
        puts "#{input} not Found"
    elsif element.count == 1

      if Fighter.all.include?(element[0])
        self.print_bio_options 
        self.print_fighter(element[0])
        puts element[0].bio_summery
        puts "\n----------------------------------\n\n"
        self.print_full_bio?(element[0])
      else
      self.weightclass_info_menu(element[0])
      end

    else
      self.print_all(element)
    end
  end

  
  def main_menu #<<< Level One
    input = nil

    until input == 'exit' || input == 'quit'
    system('clear')
    self.print_main_commands

      input = gets.strip

      case input
      when '1'
        self.fighter_menu
      when '2'
        self.weightclass_main_menu
      end

    end
    self.quit_program
  end
  

  def fighter_menu #<<< Level Two
    system('clear')
    self.print_fighter_commands

    input = nil

    until input == 'back'
      input = gets.strip
      system('clear')
      self.print_fighter_commands
      self.selection_tool(Fighter.find_by_include(input), input) unless input == 'back'
    end
  end
  
  
  def print_full_bio?(fighter) #<<< Level Three
    input = nil

    until input == 'back' || input == '1'
      input = gets.strip

       case input
       when '1'
         system('clear')
         self.print_fighter_commands
         self.print_fighter(fighter)
         puts fighter.full_bio
         puts "\n--------------------------------------\n\n"
       when 'back'
         system('clear')
         self.print_fighter_commands
       end
    end
  end
  

  def weightclass_main_menu #<<< Level Two
    input = nil
    system('clear')
    self.print_choose_weightclass_menu
    
    until input == 'back'
      input = gets.strip

      case input
      when '1'
        system('clear')
        self.print_choose_weightclass_menu
        self.print_all(WeightClass.all)
      else
      self.selection_tool(WeightClass.find_by_include(input), input) unless input == 'back'
      end
    end
  end


  def weightclass_info_menu(weightclass) #<< Level 3
    system('clear')
    self.print_weightclass_main_menu

    input = nil

    until input == 'back'

      input = gets.strip

      case input
      when '1'
        system('clear')
        self.print_weightclass_main_menu
        self.print_all(weightclass.fighters)
      when '2'
        self.weightclass_fighter_menu(weightclass)
      when 'back'
        system('clear')
        self.print_choose_weightclass_menu
      end
    end
  end
  
  
  def weightclass_fighter_menu(weightclass) #<<< Level 3
    system ('clear')
    self.print_fighter_commands
    input = nil

    until input == 'back'
      input = gets.strip
      
      if input == 'back'
      system('clear')
      self.print_weightclass_main_menu
      else
      self.selection_tool(weightclass.find_fighter_by_weight(input), input)
      end
    end
  end
  

  def quit_program
    puts "\n\nexiting..."
    sleep(1)
    system('clear')
  end 


#  def create_tablei
#			@line_size = ((winsize.last - 165) / 2)
#			table = Terminal::Table.new :title => @list_header,:headings => ["Index".center(31),"Fighter".center(80),"Weightclass","Rank"], :rows => create_rows
#			table.style = { :padding_left => 3, :border_x => "-", :border_i => "x", :margin_left => line(" "),:width => 150}
#			table.align_column(1, :center)
#			table.align_column(0, :center)
#			table
#		end

end
