function main()
    fname = length(ARGS) == 2 ? ARGS[1] : "input.txt"
    input_str = readline(fname)
    nums = split(input_str, r"[^-0-9]+", keepempty=false)
    min_x, max_x, min_y, max_y = parse.(Int, nums)
    @assert min_y < 0  # this solution only works for negative min_y
    # Part 1
    println(sum(1:abs(min_y)-1))
end

main()
