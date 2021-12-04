input = File.open("input.txt").readlines
nums = input[0].split(",").map(&:to_i)

def board_has_won(board)
    board.any?{_1.all?{|v| v == -1 }} || board.transpose.any?{_1.all?{|v| v == -1 }}
end

# Part 1
boardnums = input[2..].join.split.map(&:to_i)
nums.each do |n|
    boardnums.map!{ |x| x == n ? -1 : x }
    boards = boardnums.each_slice(5).each_slice(5).to_a
    if win = boards.find{ |b| board_has_won(b) }
        puts win.flatten.select(&:positive?).sum * n
        break
    end
end

# Part 2
boardnums = input[2..].join.split.map(&:to_i)
last_won = nil
won_boards = {}
nums.each do |n|
    boardnums.map!{|x| x == n ? -1 : x}
    boards = boardnums.each_slice(5).each_slice(5).to_a
    boards.each_with_index{|b,i|
        next if won_boards[i]
        if wins = board_has_won(b)
            won_boards[i] = true
            last_won = b
        end
    }
    if won_boards.size == boards.size
        puts last_won.flatten.select{|x| x >= 0}.sum * n
        break
    end
end
