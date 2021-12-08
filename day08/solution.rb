input = File.open('input.txt').readlines.map{|line|
    digits, output = line.split(' | ')
    [digits.split, output]
}

SEGMENTS = ?a..?g

def segments_to_digit(segment_str)
    sorted = segment_str.chars.sort.join
    %w(abcefg cf acdeg acdfg bcdf abdfg abdefg acf abcdefg abcdfg).index{
        _1 == sorted
    }
end

def decode_line(digits, output)
    # Use this table to look up how many times each
    # segment must appear (since we know that all
    # digits 0-9 appear exactly once):
    #  -----------------------------+ LEN
    #    0  =  a  b  c     e  f  g  |  6
    #    1  =        c        f     | (2)
    #    2  =  a     c  d  e     g  |  5
    #    3  =  a     c  d     f  g  |  5
    #    4  =     b  c  d     f     | (4)
    #    5  =  a  b     d     f  g  |  5
    #    6  =  a  b     d  e  f  g  |  6
    #    7  =  a     c        f     | (3)
    #    8  =  a  b  c  d  e  f  g  | (7)
    #    9  =  a  b  c  d     f  g  |  6
    #  -----------------------------+
    # COUNT =  8 (6) 8  7 (4)(9) 7

    # From rows:
    one = digits.find{_1.size == 2}.chars
    four = digits.find{_1.size == 4}.chars
    seven = digits.find{_1.size == 3}.chars
    
    # Columns:
    count = digits.join.chars.tally

    # Use set operations (- for difference, & for union) to figure out
    # which letter is which
    mapping = {}
    
    # seven and one are known, top segment is just their difference
    mapping['a'] = seven - one
    mapping['b'] = SEGMENTS.select{|k| count[k] == 6 }
    # Only 'a' and 'c' appear 8 times.
    # 'a' is already known.
    mapping['c'] = SEGMENTS.select{|k| count[k] == 8 } - mapping['a']
    # Only 'd' and 'g' appear 7 times.
    # Segment 'd' is lit in number four (which is known).
    mapping['d'] = SEGMENTS.select{|k| count[k] == 7 } & four
    mapping['e'] = SEGMENTS.select{|k| count[k] == 4 }
    mapping['f'] = SEGMENTS.select{|k| count[k] == 9 }
    mapping['g'] = SEGMENTS.select{|k| count[k] == 7 } - four
    
    # Translate output to original segments
    output.tr!(mapping.values.join, mapping.keys.join)
    # Get digits from lit segments
    output.split.map{ segments_to_digit(_1) }
    # Combine digits to make an integer
          .join.to_i
end

# Part 1
p input.sum{|_, output|
    output.split.count{ [2, 3, 4, 7].include?(_1.size) }
}

# Part 2
p input.sum{|signal_patterns, output|
    decode_line(signal_patterns, output)
}
