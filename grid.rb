NEIGHBOR_OFFSETS = [-1, 0, 1].repeated_permutation(2).to_a
NEIGHBOR_OFFSETS.delete [0,0]

class Grid

  def initialize opts={}
    opts = {width: 5, height: 5}.merge(opts)

    # NEIGHBOR_OFFSETS.each {|coord| puts "[#{coord[0]}, #{coord[1]}]"}

    @num_live_neighbors_by_dead_cells = {}
    @num_live_neighbors_by_live_cells = {}

    @matrix = [];
    
    opts[:height].times do |i|
      @matrix[i] = []

      opts[:width].times do |j|
        @matrix[i][j] = [:x, :o].sample      
      end
    end
  end

  def to_s
    @matrix.inject("") do |combined_rows, row|
      formatted_row = row.inject("") { |combined_cells, cell| "#{combined_cells} #{cell}" }
      "#{combined_rows}\n#{formatted_row}"
    end
  end
    
  def is_alive row, column
    @matrix[row][column] == :o
  end

  def next_gen_status row, column

  end

  def should_die? row, column

  end

  def in_bounds? row, column
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
  def set_num_live_neighbors_at_live_cell row, column
    return if !is_alive row, column

    NEIGHBOR_OFFSETS.each do |offset_factor|
      neighbor_row = row + offset_factor[0]
      neighbor_column = column + offset_factor[1]

      if in_bounds? neighbor_row, neighbor_column
        if is_alive neighbor_row, neighbor_column
          add_live_cell_num_neighbors [row, column]
          puts "[#{neighbor_row}, #{neighbor_column}] is a live neighbor to [#{row}, #{column}]"
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

  def add_dead_cell_num_neighbors position
    if @num_live_neighbors_by_dead_cells.has_key? position
      @num_live_neighbors_by_dead_cells[position] += 1
    else
      @num_live_neighbors_by_dead_cells[position] = 1
    end
  end

  def add_live_cell_num_neighbors position
    if @num_live_neighbors_by_live_cells.has_key? position
      @num_live_neighbors_by_live_cells[position] += 1
    else
      @num_live_neighbors_by_live_cells[position] = 1
    end
  end
end