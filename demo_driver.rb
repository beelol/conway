require "./grid"

def drive
  puts "now starting with demo"

  demo_grid = Grid.new width: 10, height: 10
  puts demo_grid

  puts demo_grid.num_live_neighbors 2, 2
end