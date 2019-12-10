#BSD 3-Clause License
#Copyright (c) 2019, Kenneth Andrews All rights reserved.
#All rights reserved.

class Cli

  include Tools
  

  #-------------------------------CLI PRINTING------------------------------
  
  def print_main_commands
    puts "\n"
    puts "   --------------------------------------------------------------"
    puts "  |                          'Main Menu'                         |"
    puts "  |                         ------------                         |"
    puts "  |                                                              |"
    puts "  |  [fighters] - List information about fighters                |"
    puts "  |  [division] - List divisions and their fighters              |"
    puts "  |  [quit] or exit: to leave program                            |"
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
    puts "  |  [back]: Go back to main menu                                |" 
    puts "  |                                                              |"
    puts "   --------------------------------------------------------------"
    puts "\n"
  end


  def print_no_fighter
    system('clear')
    self.print_fighter_commands
    puts "Could not Find Fighter"
    puts "----------------------"
    puts "\n"
  end


  def print_fighter(fighter) 
    system('clear')
   
    self.print_fighter_commands
    puts "\n"
    puts "| [1] - List Full Bio  | [back] - back to search |"
    puts "\n"
    puts fighter.name
    puts "Pro MMA record: #{fighter.record}" 
    puts fighter.display_ranks
    puts "\n"
    puts "--------------------------------"
    puts fighter.bio_summery
  end

  
  def print_all(input)
    system('clear')
    print_fighter_commands

    input.each_with_index do |fighter, index| 
      index += 1
      index = index.to_s
      index = index.gsub(index, "00#{index}") if index.to_i < 10 
      index = index.gsub(index, "0#{index}") if index.to_i < 100 && index.to_i > 9 
    
      puts "#{index}: #{fighter.name} : #{fighter.weightclass[0].name} - rank: #{fighter.rank[0].rank}"
    end
    puts "----------------------------------------------------------------------"
    puts "\n"
  end

  #---------------CLI Menus------------------------

  def main_menu
    input = nil

    until input == 'exit' || input == 'quit'
    system('clear')
    self.print_main_commands
      input = gets.strip

      case input
      when 'fighters'
        self.fighter_menu
      end
    end
    self.quit_program
  end
  

  def fighter_menu
    system('clear')
    input = nil
    self.print_fighter_commands

    until input == 'back'
      input = gets.strip

      self.get_fighter(input) unless input == 'back' 
    end
  end


  def print_full_bio?(fighter)
    input = nil
    until input == 'back' || input == '1'
      input = gets.strip
       case input
       when '1'
         system('clear')
         self.print_fighter(fighter)
         puts fighter.full_bio
       end
    end
  end
  
  
  def get_fighter(input)
    fighters = Fighter.find_by_include(input)
    if fighters.count == 0
      self.print_no_fighter
    elsif fighters.count == 1
      self.print_fighter(fighters[0])
      self.print_full_bio?(fighters[0])
    else
      self.print_all(fighters)
    end
  end
  
  
  def quit_program
    puts "\n\n                 exiting..."
    sleep(1)
    system('clear')
  end 


#  def create_table
#			@line_size = ((winsize.last - 165) / 2)
#			table = Terminal::Table.new :title => @list_header,:headings => ["Index".center(31),"Fighter".center(80),"Weightclass","Rank"], :rows => create_rows
#			table.style = { :padding_left => 3, :border_x => "-", :border_i => "x", :margin_left => line(" "),:width => 150}
#			table.align_column(1, :center)
#			table.align_column(0, :center)
#			table
#		end

end
