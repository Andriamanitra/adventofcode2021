input = File.open("input.txt").read.split.map{|line| line.chars.map(&:to_i) }
MAXW = input[0].size - 1
MAXH = input.size - 1

pathlen = input.map{ |row| row.map{ 69000 } }

q = []
q << [MAXH, MAXW, input[MAXH][MAXW]]
until q.empty?
    r, c, len = q.pop
    next if len >= pathlen[r][c]
    pathlen[r][c] = len
    # I assumed moving up or left is not possible since the
    # example didn't have any movement other than down and
    # right, and it seemed to work:
    q << [r - 1, c, len + input[r - 1][c]] if r > 0
    q << [r, c - 1, len + input[r][c - 1]] if c > 0
end

# Part 1
p pathlen[0][0] - input[0][0]

# 5x5 grid for part 2
input = input.map do |row|
    (0..4).flat_map{|i| row.map{|v| v + i } }
end
input = (0..4).flat_map do |i|
    input.map{|row| row.map{|v| (v + i - 1) % 9 + 1 } }
end
MAXW5 = input[0].size - 1
MAXH5 = input.size - 1

# TODO: Part 2 pathfinding
