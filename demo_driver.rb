require './grid'
require 'io/console'                                                                                                       

def drive
  width = 10
  height = 10

  demo_grid = Grid.new width: width, height: height, live_cells: [[height/2 - 1, width/2 - 1], [height/2, width/2], [height/2 - 1, width/2 + 1]]
  # puts demo_grid.set_num_live_neighbors_at_live_cell 2, 2
  # puts demo_grid.set_num_live_neighbors_at_live_cell *gets.chomp.split(',').map(&:to_i)

  # puts demo_grid.should_come_alive? height/2 - 1, width/2

  while true do
    system 'clear'
    puts "Welcome to the game of life!"
    puts "To play, press any key when prompted to view the progression! The first generation is presented below."
    puts "To exit at any time, press the e key."
    
    puts demo_grid

    exit if STDIN.getch.downcase == "e"
    
    demo_grid.tick
  end
end
