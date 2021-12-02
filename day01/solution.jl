input = parse.(Int, readlines("input.txt"))

part1 = count(a < b for (a, b) in zip(input, input[2:end]))
println(part1)

part2 = count(a < b for (a, b) in zip(input, input[4:end]))
println(part2)
