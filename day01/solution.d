import std.algorithm;
import std.array;
import std.conv;
import std.range;
import std.stdio;
import std.string;

void main() {
    int[] input = File("input.txt").byLine.map!(a => a.to!int).array;

    int part1 = 0;
    int part2 = 0;
    foreach(i; 0..input.length) {
        if (i > 0 && input[i] > input[i-1]) part1++;
        if (i > 3 && input[i] > input[i-3]) part2++;
    }

    writeln(part1);
    writeln(part2);
}
