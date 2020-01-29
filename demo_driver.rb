require "./grid"

def drive
  puts "now starting with demo"

  demo_grid = Grid.new width: 10, height: 10
  puts demo_grid
  puts demo_grid.is_alive 0, 0
end