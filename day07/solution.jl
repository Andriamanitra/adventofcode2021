using Plots

function main()
    input_str = readlines("input.txt")[1]
    input = parse.(Int, split(input_str, ','))
    part1_fuel_usage(mid) = sum(x -> abs(x - mid), input)
    part2_fuel_usage(mid) = sum(x -> sum(1:abs(x - mid)), input)
    min_pos, max_pos = extrema(input)
    pos_range = min_pos:max_pos

    part1 = part1_fuel_usage.(pos_range)
    part2 = part2_fuel_usage.(pos_range)

    plot(part1, x=pos_range, color=:red, label="Part 1")
    val, i = findmin(part1)
    scatter!([(i, val)], marker=:x, color=:red, label="Optimal solution")
    
    plot!(part2, x=pos_range, color=:blue, label="Part 2")
    val, i = findmin(part2)
    scatter!([(i, val)], marker=:x, color=:blue, label="Optimal solution")

    plot!(
        title="Advent of Code day 7: Crab alignment",
        yaxis=:log,
        yticks=[10^i for i=4:9],
        ylim=(10^5,4*10^9),
        xlim=(min_pos, max_pos),
        ylabel="Fuel spent",
        xticks=0:250:2000,
        xlabel="Align position",
        legend=:topleft
    )
    return part1, part2
end

part1, part2 = main()
