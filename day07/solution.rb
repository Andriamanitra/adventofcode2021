input = File.open('input.txt').read.split(",").map(&:to_i)

# Part 1
# Median value
input.sort!
mid = input[input.size / 2]
puts input.sum{ (mid - _1).abs }

# Part 2
# Start from mean
i = input.sum / input.size
# Hash to remember past results
total_fuel_spent = Hash.new{|h,k|
    h[k] = input.sum{
        dist = (k - _1).abs
        dist * (dist + 1) / 2  # Sum of numbers 1..dist
    }
}
# Walk to the direction where total fuel spent gets smaller
direction = total_fuel_spent[i] <=> total_fuel_spent[i + 1]
while total_fuel_spent[i + direction] < total_fuel_spent[i]
    i += direction
end
puts total_fuel_spent[i]
