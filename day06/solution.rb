input = File.open("input.txt").read.split(",").map(&:to_i)

fish = [0] * 9
input.each do |age|
    fish[age] += 1
end

(1..256).each do |i|
    puts fish.sum if i == 80 || i == 256
    fish[(i + 7) % 9] += fish[i % 9]
end
