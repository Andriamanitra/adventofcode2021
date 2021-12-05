get_numbers(s) = parse.(Int, split(s, r"\D+"))

function main()
    input = readlines("input.txt")
    line_segments = get_numbers.(input)

    part1 = Dict()
    part2 = Dict()

    for (x0, y0, x1, y1) in line_segments
        maxlen = max(abs(x1 - x0), abs(y1 - y0)) + 1
        xs = range(x0, x1, length=maxlen)
        ys = range(y0, y1, length=maxlen)
        for p in zip(xs, ys)
            if x0 == x1 || y0 == y1
                part1[p] = get!(part1, p, 0) + 1
            end
            part2[p] = get!(part2, p, 0) + 1
        end
    end

    count_intersections(x) = count(>(1), values(x))

    println(count_intersections(part1))
    println(count_intersections(part2))
end

main()
