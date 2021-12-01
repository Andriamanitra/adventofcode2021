input = File.read_lines("input.txt").map(&.to_i)

# Part 1
p input.each_cons(2).count{ |(a,b)| b > a }

# Part 2
p input.each_cons(4).count{ |(a,_,_,b)| b > a }
