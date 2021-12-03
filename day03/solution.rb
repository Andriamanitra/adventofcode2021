input = File.open("input.txt").read.split.map(&:chars)
BITLENGTH = input[0].size


# Part 1
colsums = Array.new(BITLENGTH){0}
input.each do |line|
    (0...BITLENGTH).each do |i|
        colsums[i] += line[i].to_i
    end
end

gamma = colsums.map{ 2 * _1 / input.size }.join.to_i(2)

# Flip all bits to get epsilon
mask = 2 ** BITLENGTH - 1
epsilon = ~gamma & mask

puts gamma * epsilon


# Part 2
def most_common_bit_at_position(arr, i)
    2 * arr.count{_1[i] == "1"} / arr.size
end

def least_common_bit_at_position(arr, i)
    most_common_bit_at_position(arr, i) ^ 1
end

oxy = input.dup
(0..).find{|i|
    most_common = most_common_bit_at_position(oxy, i)
    oxy.select!{_1[i].to_i == most_common}
    oxy.size == 1
}
oxy = oxy[0].join.to_i(2)

co2 = input.dup
(0..).find{|i|
    least_common = least_common_bit_at_position(co2, i)
    co2.select!{_1[i].to_i == least_common}
    co2.size == 1
}
co2 = co2[0].join.to_i(2)

p oxy * co2
