input = File.open("input.txt").readlines

pair = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

# Part 1
values = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
puts input.sum{|line|
    stack = []
    illegal = line.each_char.find do |ch|
        if "[{(<"[ch]
            stack << ch
            false
        elsif "]})>"[ch]
            ch != pair[stack.pop]
        end
    end
    values[illegal] || 0
}

# Part 2
values = {")" => 1, "]" => 2, "}" => 3, ">" => 4}
scores = input.map{|line|
    stack = []
    illegal = line.each_char.find do |ch|
        if "[{(<"[ch]
            stack << ch
            false
        elsif "]})>"[ch]
            ch != pair[stack.pop]
        end
    end
    next 0 if illegal
    score = 0
    stack.reverse_each{|x|
        score *= 5
        score += values[pair[x]]
    }
    score
}
scores.reject!(&:zero?)
puts scores.sort[scores.size / 2]
