NEIGHBOR_OFFSETS = [-1, 0, 1].repeated_permutation(2).to_a
NEIGHBOR_OFFSETS.delete [0, 0]

class Grid
  @@live_cell_symbol = :X
  @@dead_cell_symbol = :"."

  def self.live_cell_symbol
    @@live_cell_symbol
  end

  def self.dead_cell_symbol
    @@dead_cell_symbol
  end

  def initialize(opts = {})
    opts = {matrix: [], width: 5, height: 5, live_cells: []}.merge(opts)

    @num_live_neighbors_by_dead_cells = {}
    @num_live_neighbors_by_live_cells = {}

    @matrix = opts[:matrix]
    @live_cells = opts[:live_cells]

    unless @matrix.length > 0
      opts[:height].times do |i|
        @matrix[i] = []

        opts[:width].times { |j| @matrix[i][j] = @live_cells.include?([i, j]) ? @@live_cell_symbol : @@dead_cell_symbol }
      end
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
    @matrix[row][column] == @@live_cell_symbol
  end

  def tick
    # memoize number of neighbors for live cells
    # and dead cells with any adjacent live cells
    @live_cells.each { |live_cell| set_num_live_neighbors_at_live_cell(live_cell[0], live_cell[1]) }

    # update to next generation
    overwrite_matrix_with_next_generation

    # clear memoized values for next generation to determine neighbors
    @num_live_neighbors_by_dead_cells = {}
    @num_live_neighbors_by_live_cells = {}
  end

  def overwrite_matrix_with_next_generation
    # if the cell should come alive, change it in the matrix to be alive for next generation
    new_dead_cells = []
    new_live_cells = []

    @num_live_neighbors_by_live_cells.each do |key, value| 
      if should_die? *key 
        new_dead_cells << key unless new_dead_cells.include? key
      end
    end

    @num_live_neighbors_by_dead_cells.each do |key, value| 
      if should_come_alive? *key
        new_live_cells << key unless new_live_cells.include? key
      end
    end

    new_dead_cells.each do |pos| 
      @matrix[pos[0]][pos[1]] = @@dead_cell_symbol 
      @live_cells.delete pos 
    end
    
    new_live_cells.each do |pos| 
      @matrix[pos[0]][pos[1]] = @@live_cell_symbol 
      @live_cells << pos 
    end
  end

  # Only for use with dead cells
  def should_come_alive?(row, column)
    #  Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    @num_live_neighbors_by_dead_cells[[row, column]] == 3
  end

  # Only for use with live cells
  def should_die?(row, column)
    num_live_neighbors = @num_live_neighbors_by_live_cells[[row, column]]

    #  Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
    
    #  Any live cell with more than three live neighbours dies, as if by overpopulation
    return true if (num_live_neighbors < 2 || num_live_neighbors > 3)
      
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
    @num_live_neighbors_by_live_cells[[row, column]] = 0

    NEIGHBOR_OFFSETS.each do |offset_factor|
      neighbor_row = row + offset_factor[0]
      neighbor_column = column + offset_factor[1]

      if in_bounds? neighbor_row, neighbor_column
        if is_alive? neighbor_row, neighbor_column
          add_live_cell_num_neighbors [row, column]
        else
          add_dead_cell_num_neighbors [neighbor_row, neighbor_column]
        end
      end
    end
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
