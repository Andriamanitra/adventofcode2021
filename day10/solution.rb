input = File.open("input.txt").readlines

OPENING = "([{<"
CLOSING = ")]}>"

class String
    def find_illegal
        stack = []
        illegal = self.each_char.find do |ch|
            if OPENING[ch]
                !(stack << ch)
            elsif CLOSING[ch]
                ch.tr(CLOSING,OPENING) != stack.pop
            end
        end
        [illegal, stack]
    end
end

# Part 1
scores = input.sum do |line|
    case line.find_illegal
    in [nil, _] then 0
    in [val, _] then [3, 57, 1197, 25137][CLOSING.index(val)]
    end
end
puts scores

# Part 2
scores = input.filter_map do |line|
    case line.find_illegal
    in [nil, stack] then stack.join.reverse.tr(OPENING, "1234").to_i(5)
    in [val, stack] then nil
    end
end
puts scores.sort[scores.size / 2]
