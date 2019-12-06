class Cli


  def initialize
    @fighters = []
    @weightclasses = []
    self.fighters
    self.weightclasses
  end


  def print_commands
    puts "To list Fighters of a weightclass type the name of that weightclass. eg. 'heavyweight, lightweight': " 
    puts "To list information about a fighter type in their first and last name. eg. 'Donald Cerrone': " 
  end


  def fighters
    @fighters << Fighter.all 
  end


  def weightclasses
    @weightclasses << Weightclass.all
  end


  def input_valid?(input)
    @fighters.include?(input) || @weightclasses.include?(input) || input == exit
  end


  def selection
    
  end


  def get_input
    input = ''

    while input == !exit
      
      print_commands

      input = gets.chomp
      command_valid?(input)
    end
  end



end
