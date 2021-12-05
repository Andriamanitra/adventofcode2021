using Colors, Plots

get_numbers(s) = parse.(Int, split(s, r"\D+"))

function main()
    input = readlines("input.txt")
    line_segments = get_numbers.(input)

    part1 = Dict()
    part2 = Dict()

    anim = @animate for (x0, y0, x1, y1) in line_segments
        maxlen = max(abs(x1 - x0), abs(y1 - y0)) + 1
        xs = range(x0, x1, length=maxlen)
        ys = range(y0, y1, length=maxlen)
        for p in zip(xs, ys)
            if x0 == x1 || y0 == y1
                part1[p] = get!(part1, p, 0) + 1
            end
            part2[p] = get!(part2, p, 0) + 1
        end
        plot_points(part2)  # plot frame for animation
    end

    gif(anim, "anim.mp4", fps=60)  # save animation as a video file
end

function plot_points(point_dict)
    img = ones(Float64, 1000, 1000)
    for (k, v) in point_dict
        img[Int.(k)...] = 1.0 - v / 7.0
    end
    plot(Gray.(img), size=(1000,1000), axis=false, ticks=false)
end

main()
