input = File.open("input.txt").readlines.map(&:to_i)

# Part 1
p input.each_cons(2).count{ |a,b| b > a }

# Part 2
p input.each_cons(3).map(&:sum).each_cons(2).count{ |a,b| b > a }
