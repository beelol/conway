require './grid'
require 'io/console'                                                                                                       

def drive
  puts "Welcome to the game of life!"
  puts "Please enter the name of one of the following seeds:"
  puts
  Dir.entries("./seeds").each {|name| puts name.split(".")[0] if name != "." && name != ".." }

  next_seed = gets.chomp
  
  demo_grid = load_seed_as_grid next_seed

  generation = 0

  while true do
    system 'clear'
    puts "Welcome to the game of life!"
    puts "To play, press any key when prompted to view the progression! The first generation is presented below."
    puts "To exit at any time, press the e key."
    
    puts "Generation #{generation += 1}:"
    puts demo_grid

    exit if STDIN.getch.downcase == "e"
    
    demo_grid.tick
  end
end

def load_seed_as_grid name
  matrix = []
  live_cells = []
  line_index = 0

  File.foreach("./seeds/#{name}.txt") do |line|
    matrix << line.split("").each_with_index.map do |char, char_index|
        sym = char.to_sym
        
        live_cells << [line_index, char_index] if sym == Grid.live_cell_symbol
        
        sym
    end
    
    line_index += 1
  end

    # live_cells.each {|e| puts "#{e[0]}, #{e[1]}"}

  Grid.new matrix: matrix, live_cells: live_cells
end
