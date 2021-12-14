input = File.open("input.txt").read

FIRSTCHAR = input[0]
s, rules = input.split("\n\n")
pairs = (0..s.size-2).map{ s[_1, 2] }.tally
subs = {}
rules.each_line do |line|
    a, _, b = line.split
    subs[a] = b
end

def solve(steps, pairs, subs)
    steps.times do
        pairs, *other_hashes = pairs.map do |k, v|
            mid = subs[k]
            next { k => v } if mid.nil?
            left, right = k.chars
            { left + mid => v, mid + right => v}
        end
        pairs.merge!(*other_hashes){ |k, v1, v2| v1 + v2 }
    end

    elements = Hash.new { 0 }
    elements[FIRSTCHAR] = 1
    pairs.each do |k,v|
        elements[k[1]] += v
    end

    least, most = elements.values.minmax
    return most - least
end

# Part 1
puts solve(10, pairs, subs)

# Part 2
puts solve(40, pairs, subs)
