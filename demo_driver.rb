require './grid'

def drive
  puts 'now starting with demo'

  demo_grid = Grid.new width: 10, height: 10
  puts demo_grid

  # puts demo_grid.set_num_live_neighbors_at_live_cell 2, 2
  puts demo_grid.set_num_live_neighbors_at_live_cell *gets.chomp.split(',').map(&:to_i)
end
