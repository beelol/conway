require './grid'

def drive
  puts 'now starting with demo'

  width = 10
  height = 10

  demo_grid = Grid.new width: width, height: height, live_cells: [[height/2 - 1, width/2 - 1], [height/2, width/2], [height/2 - 1, width/2 + 1]]
  puts demo_grid

  # puts demo_grid.set_num_live_neighbors_at_live_cell 2, 2
  # puts demo_grid.set_num_live_neighbors_at_live_cell *gets.chomp.split(',').map(&:to_i)

  puts demo_grid.should_come_alive? height/2 - 1, width/2
end
