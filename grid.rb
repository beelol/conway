class Grid

  def initialize opts={}
    opts = {width: 5, height: 5}.merge(opts)

    @matrix = [];
    
    opts[:width].times do |i|
      @matrix[i] = []

      opts[:height].times do |j|
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
    
  def is_alive column, row
    @matrix[column][row] == :o
  end

  def next_gen_status column, row

  end

  def should_die? column, row

  end

  def in_bounds? column, row
    left_in_bounds = row >= 0
    right_in_bounds = row < @matrix[0].length
    top_in_bounds = column >= 0
    bottom_in_bounds = column < @matrix.length

    left_in_bounds && right_in_bounds && top_in_bounds && bottom_in_bounds
  end
end