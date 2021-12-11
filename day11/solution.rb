ENERGY_REQUIRED_TO_FLASH = 10
ENERGY_GAIN_PER_STEP = 1
FLASH_RANGE = 1
FLASH_STRENGTH = 1

input = File.open("input.txt").read.split.map{_1.chars.map(&:to_i)}
ROWS = input.size
MAXROW = ROWS - 1
COLS = input[0].size
MAXCOL = COLS - 1
octopi = input.flatten

flashes = 0
part1 = nil
part2 = nil
(1..).find { |iteration|
    flashed = octopi.map { false }
    octopi.map! { _1 + ENERGY_GAIN_PER_STEP }
    while octopi.zip(flashed).any? { |v,f| v >= ENERGY_REQUIRED_TO_FLASH && !f }
        octopi.each_index do |i|
            next if octopi[i] < ENERGY_REQUIRED_TO_FLASH || flashed[i]
            flashes += 1
            flashed[i] = true
            row, col = i.divmod(COLS)
            row_from = [0, row - FLASH_RANGE].max
            row_to = [MAXROW, row + FLASH_RANGE].min
            col_from = [0, col - FLASH_RANGE].max
            col_to = [MAXCOL, col + FLASH_RANGE].min
            (col_from..col_to).each do |col|
                (row_from..row_to).each do |row|
                    octopi[row * COLS + col] += FLASH_STRENGTH
                end
            end
        end
    end
    octopi.map!{_1 >= ENERGY_REQUIRED_TO_FLASH ? 0 : _1}
    part1 = flashes if part1.nil? && iteration == 100
    part2 = iteration if part2.nil? && flashed.all?
    part1 && part2
}
puts part1, part2
