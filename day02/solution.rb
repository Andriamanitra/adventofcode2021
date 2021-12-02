input = File.open("input.txt").readlines

# Part 1
x = 0
y = 0
for line in input
    instr, num = line.split
    num = num.to_i
    if instr == "forward"
        x += num
    elsif instr == "down"
        y += num
    elsif instr == "up"
        y -= num
    end
end
puts x * y

# Part 2
aim = 0
x = 0
y = 0
for line in input
    instr, num = line.split
    num = num.to_i
    if instr == "forward"
        x += num
        y += aim * num
    elsif instr == "down"
        aim += num
    elsif instr == "up"
        aim -= num
    end
end
puts x * y
