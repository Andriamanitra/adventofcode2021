use std::fs;

fn main() {
    let input = fs::read_to_string("input.txt").expect("Failed to read input.txt");
    let nums: Vec<usize> = input.lines().map(|s| s.parse::<usize>().unwrap()).collect();

    // Part 1
    let mut part1: usize = 0;
    for i in 0..nums.len() - 1 {
        if nums[i] < nums[i + 1] {
            part1 += 1;
        }
    }
    println!("{}", part1);

    // Part 2
    let mut part2: usize = 0;
    for i in 0..nums.len() - 3 {
        if nums[i] < nums[i + 3] {
            part2 += 1;
        }
    }
    println!("{}", part2);
}
