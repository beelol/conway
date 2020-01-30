require './grid'
require 'io/console'                                                                                                       

def drive
  puts "Welcome to the game of life!"
  puts "Please type the name of one of the following seeds and press enter to simulate:"
  puts
  Dir.entries("./seeds").each {|name| puts name.split(".")[0] if name != "." && name != ".." }

  next_seed = gets.chomp
  
  demo_grid = load_seed_as_grid next_seed

  generation = 0

  500.times { generation += 1; run_simulation demo_grid, generation }
end

def run_simulation grid, generation
  t = Time.now
  
  system 'clear'
  puts "To exit at any time, kill the process by pressing control + c."
  
  puts "Generation #{generation}:"
  puts grid
  
  grid.tick

  sleep(t + 0.09 - Time.now)
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

  Grid.new matrix: matrix, live_cells: live_cells
end
