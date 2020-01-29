NEIGHBOR_OFFSETS = [-1, 0, 1].repeated_permutation(2).to_a
NEIGHBOR_OFFSETS.delete [0,0]



class Grid

  def initialize opts={}
    opts = {width: 5, height: 5}.merge(opts)

    # NEIGHBOR_OFFSETS.each {|coord| puts "[#{coord[0]}, #{coord[1]}]"}

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

  def num_live_neighbors row, column
    num_found_live_neighbors = 0

    NEIGHBOR_OFFSETS.each do |offset_factor|
      neighbor_row = row + offset_factor[0]
      neighbor_column = column + offset_factor[1]

      if in_bounds? neighbor_row, neighbor_column
        if is_alive neighbor_row, neighbor_column
           num_found_live_neighbors += 1
           puts "[#{neighbor_row}, #{neighbor_column}] is a live neighbor to [#{row}, #{column}]"
        else
          puts "[#{neighbor_row}, #{neighbor_column}] is in bounds"
        end
      else
        puts "[#{neighbor_row}, #{neighbor_column}] is out of bounds"
      end
    end

    num_found_live_neighbors
  end
end