input = File.open('input.txt').read.split(',').map(&:to_i)

fish = [0] * 9
input.each do |age|
    fish[age] += 1
end

256.times do |i|
    fish[(i + 7) % 9] += fish[i % 9]
    puts fish.sum if i == 79 || i == 255
end
