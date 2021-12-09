input = File.open("input.txt").readlines.map{_1.chomp.chars.map(&:to_i)}

ROWS = input.size
COLS = input[0].size

low_points = []

(0...ROWS).each do |r|
    (0...COLS).each do |c|
        val = input[r][c]
        
        neighbors = []
        neighbors << input[r-1][c] if r > 0
        neighbors << input[r+1][c] if r+1 < ROWS
        neighbors << input[r][c-1] if c > 0
        neighbors << input[r][c+1] if c+1 < COLS
        if val < neighbors.min
            low_points << [r, c, val]
        end
    end
end

def basin(grid, start)
    # Flood fill until hitting 9
    q = [start]
    visited = {}
    until q.empty?
        r, c = q.pop
        if grid[r][c] == 9
            next
        end
        visited[[r,c]] = true
        q << [r-1, c] if r > 0 && !visited[[r-1,c]]
        q << [r+1, c] if r+1 < ROWS && !visited[[r+1,c]]
        q << [r, c-1] if c > 0 && !visited[[r,c-1]]
        q << [r, c+1] if c+1 < COLS && !visited[[r,c+1]]
    end

    return visited.keys
end

# Part 1
puts low_points.sum{ |_, _, height| height + 1 }

# Part 2
puts low_points.map{|r, c, _|
    basin(input, [r, c]).size
}.max(3).inject(:*)
