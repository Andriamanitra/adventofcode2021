using DSP # for convolutions


const OctopusType = rand((Int, Float32))
const ENERGY_REQUIRED_TO_FLASH = 10
const ENERGY_GAIN_PER_STEP = 1
const FLASH = ones(OctopusType, 3, 3)

function read_char_grid(fname::String)
    input = readlines(fname)
    ROWS = length(input)
    COLS = length(input[1])
    grid = Array{Char}(undef, ROWS, COLS)
    for r in 1:ROWS
        if length(input[r]) != COLS
            throw("Error: Contents of the file don't form a rectangle")
        end
        for c in 1:COLS
            grid[r, c] = input[r][c]
        end
    end
    grid
end

function step(octopi::Matrix{T} where T <: Real)
    octopi .+= ENERGY_GAIN_PER_STEP
    flashed = falses(size(octopi))
    flashing = octopi .>= ENERGY_REQUIRED_TO_FLASH
    while any(flashing)
        octopi .+= conv(flashing, FLASH)[2:end-1, 2:end-1]
        flashed .|= flashing
        @. flashing = octopi >= ENERGY_REQUIRED_TO_FLASH
        @. flashing &= !flashed
    end
    octopi[flashed] .= zero(eltype(octopi))
    count(flashed)
end

function part1(octopi::Matrix{T} where T <: Real)
    sum(step(octopi) for i=1:100)
end

function part2(octopi::Matrix{T} where T <: Real)
    iterations = 1
    while step(octopi) < length(octopi)
        iterations += 1
    end
    iterations
end

function main()
    input = parse.(Int, read_char_grid("input.txt"))
    octopi = convert.(OctopusType, input)
    octopi |> copy |> part1 |> println
    octopi |> copy |> part2 |> println
end

main()