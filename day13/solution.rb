input = File.open('input.txt').read
points, instructions = input.split("\n\n")
points = points.split.map { |line| line.split(',').map(&:to_i) }

class Paper
  attr_reader :points

  def initialize(points)
    @points = points
    @width  = points.map { |x, _y| x }.max + 1
    @height = points.map { |_x, y| y }.max + 1
  end

  def vertical_fold!(fold)
    @points.map! do |x, y|
      x = fold - (x - fold) if x > fold
      [x, y]
    end
    @points.uniq!
    @width = fold
  end

  def horizontal_fold!(fold)
    @points.map! do |x, y|
      y = fold - (y - fold) if y > fold
      [x, y]
    end
    @points.uniq!
    @height = fold
  end

  def to_s
    canvas = Array.new(@height) { ' ' * @width }
    @points.each do |x, y|
      canvas[y][x] = '█'
    end
    canvas.join("\n")
  end
end

paper = Paper.new(points)

instructions.each_line.zip(1..) do |instruction, fold_number|
  raise 'Invalid instruction!' unless instruction[/fold along (x|y)=(\d+)/]

  case $1 
  when 'x' then paper.vertical_fold!($2.to_i)
  when 'y' then paper.horizontal_fold!($2.to_i)
  end
  # Part 1
  puts paper.points.size if fold_number == 1
end

# Part 2
puts paper
