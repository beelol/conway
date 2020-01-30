NEIGHBOR_OFFSETS = [-1, 0, 1].repeated_permutation(2).to_a
NEIGHBOR_OFFSETS.delete    [0, 0]

class Grid
  def initialize(opts = {})
    opts = { width: 5, height: 5, live_cells: []}.merge(opts)

    # NEIGHBOR_OFFSETS.each {|coord| puts "[#{coord[0]}, #{coord[1]}]"}

    @num_live_neighbors_by_dead_cells = {}
    @num_live_neighbors_by_live_cells = {}

    @matrix = []
    @live_cells = opts[:live_cells]

    opts[:height].times do |i|
      @matrix[i] = []

      opts[:width].times { |j| @matrix[i][j] = @live_cells.include?([i, j]) ? :o : :x }
    end
  end

  def to_s
    @matrix.inject('') do |combined_rows, row|
      formatted_row =
        row.inject('') { |combined_cells, cell| "#{combined_cells} #{cell}" }
      "#{combined_rows}\n#{formatted_row}"
    end
  end

  def is_alive?(row, column)
    @matrix[row][column] == :o
  end

  def should_come_alive?(row, column)
    #  Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    
    @num_live_neighbors_by_dead_cells[[row, column]] == 3
  end

  def should_die?(row, column)
    return false if !is_alive? @matrix[row][column]

    num_live_neighbors = @num_live_neighbors_by_live_cells[[row, column]]

    #  Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
    fewer_than_two_live_neighbors = num_live_neighbors < 2
    
    #  Any live cell with more than three live neighbours dies, as if by overpopulation
    more_than_three_live_neighbors = num_live_neighbors > 3
    
    return true if fewer_than_two_live_neighbors || more_than_three_live_neighbors 
      
    #  Any live cell with two or three live neighbours lives on to the next generation.
    false
  end

  def in_bounds?(row, column)
    left_in_bounds = column >= 0
    right_in_bounds = column < @matrix[0].length
    top_in_bounds = row >= 0
    bottom_in_bounds = row < @matrix.length

    left_in_bounds && right_in_bounds && top_in_bounds && bottom_in_bounds
  end

  # This method will store the number of live neighbors to a live cell.
  # It will also mark itself as adjacent to a dead cell so that dead cells
  # may come alive if necessary conditions are met.

  # make sure to CLEAR the hash before next generation is set to the matrix.
  def set_num_live_neighbors_at_live_cell(row, column)
    return if !is_alive? row, column

    NEIGHBOR_OFFSETS.each do |offset_factor|
      neighbor_row = row + offset_factor[0]
      neighbor_column = column + offset_factor[1]

      if in_bounds? neighbor_row, neighbor_column
        if is_alive? neighbor_row, neighbor_column
          add_live_cell_num_neighbors [row, column]
          puts "[#{neighbor_row}, #{neighbor_column}] is a live neighbor to [#{
                 row
               }, #{column}]"
        else
          add_dead_cell_num_neighbors [neighbor_row, neighbor_column]
          puts "[#{neighbor_row}, #{neighbor_column}] is in bounds"
        end
      else
        puts "[#{neighbor_row}, #{neighbor_column}] is out of bounds"
      end
    end

    @num_live_neighbors_by_live_cells[[row, column]]
  end

  def add_dead_cell_num_neighbors(position)
    if @num_live_neighbors_by_dead_cells.has_key? position
      @num_live_neighbors_by_dead_cells[position] += 1
    else
      @num_live_neighbors_by_dead_cells[position] = 1
    end
  end

  def add_live_cell_num_neighbors(position)
    if @num_live_neighbors_by_live_cells.has_key? position
      @num_live_neighbors_by_live_cells[position] += 1
    else
      @num_live_neighbors_by_live_cells[position] = 1
    end
  end
end
