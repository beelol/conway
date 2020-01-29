class Grid

  def initialize opts={}
    opts = {width: 5, height: 5}.merge(opts)

    @matrix = [];
    
    opts[:width].times do |i|
      @matrix[i] = []

      opts[:height].times do |j|
        @matrix[i][j] = 0
      end
    end
  end

  def to_s
    @matrix.inject("") do |combined_rows, row|
      formatted_row = row.inject("") { |combined_cells, cell| "#{combined_cells} #{cell}" }
      "#{combined_rows}\n#{formatted_row}"
    end
  end
    
end