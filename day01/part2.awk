# Part 2
BEGIN { RS="" }
{
    for (i = 1; i <= NF-3; i++) {
        if ($(i+3) > $i) count++
    }
}
END { print count }
