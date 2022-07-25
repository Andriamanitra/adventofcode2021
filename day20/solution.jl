
function main()
    fname = length(ARGS) == 1 ? ARGS[1] : "input.txt"
    image_enhancement_algorithm_line = nothing
    image_lines = nothing
    open(fname, "r") do f
        image_enhancement_algorithm_line = readline(f)
        readline(f)
        image_lines = readlines(f)
    end
    read_pixels_from_string(s) = reduce(hcat, collect(s)) .== '#'
    light_pixels = read_pixels_from_string(image_enhancement_algorithm_line)
    image = reduce(vcat, read_pixels_from_string.(image_lines))
    outside = 0

    function next_image(image)
        # affected area grows by one in each direction, so 2 in total
        nxt = zeros(Int, size(image) .+ 2)
        if outside == 1
            # all of the outside pixels being lit affects
            # the two outermost rings
            nxt[begin, :] .|= 0b111111000
            nxt[end, :]   .|= 0b000111111
            nxt[:, begin] .|= 0b110110110
            nxt[:, end]   .|= 0b011011011
            nxt[begin+1, :] .|= 0b111000000
            nxt[end-1, :]   .|= 0b000000111
            nxt[:, begin+1] .|= 0b100100100
            nxt[:, end-1]   .|= 0b001001001
        end

        outside = outside == 0 ? light_pixels[1] : light_pixels[512]

        for (idx, is_lit) in pairs(image)
            if is_lit
                nxt[idx + CartesianIndex(0, 0)] |= 0b000000001
                nxt[idx + CartesianIndex(0, 1)] |= 0b000000010
                nxt[idx + CartesianIndex(0, 2)] |= 0b000000100
                nxt[idx + CartesianIndex(1, 0)] |= 0b000001000
                nxt[idx + CartesianIndex(1, 1)] |= 0b000010000
                nxt[idx + CartesianIndex(1, 2)] |= 0b000100000
                nxt[idx + CartesianIndex(2, 0)] |= 0b001000000
                nxt[idx + CartesianIndex(2, 1)] |= 0b010000000
                nxt[idx + CartesianIndex(2, 2)] |= 0b100000000
            end
        end

        map(nxt) do value
            getindex(light_pixels, value+1)
        end
    end

    # Part 1
    image |> next_image |> next_image |> sum |> println

    # Part 2
    image |> ∘([next_image for i=1:50]...) |> sum |> println
end

main()
