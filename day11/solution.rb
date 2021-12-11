POWER_TO_FLASH = 10
FLASH_RANGE = 1
FLASH_STRENGTH = 1

input = File.open("input.txt").read.split.map{_1.chars.map(&:to_i)}
ROWS = input.size
COLS = input[0].size
input.flatten!

flashes = 0
part1 = nil
part2 = nil
(1..).find { |iteration|
    flashed = input.map { false }
    input.map! { _1 + 1 }
    while input.zip(flashed).any? { |v,f| v >= POWER_TO_FLASH && !f }
        input.each_index do |i|
            next if input[i] < POWER_TO_FLASH || flashed[i]
            flashes += 1
            flashed[i] = true
            row, col = i.divmod(COLS)
            row_from = [0, row - FLASH_RANGE].max
            row_to = [ROWS - 1, row + FLASH_RANGE].min
            col_from = [0, col - FLASH_RANGE].max
            col_to = [COLS - 1, col + FLASH_RANGE].min
            (col_from..col_to).each do |col|
                (row_from..row_to).each do |row|
                    input[row * COLS + col] += FLASH_STRENGTH
                end
            end
        end
    end
    input.map!{_1 > 9 ? 0 : _1}
    part1 = flashes if part1.nil? && iteration == 100
    part2 = iteration if part2.nil? && flashed.all?
    part1 && part2
}
puts part1, part2
