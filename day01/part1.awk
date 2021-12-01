# Part 1
NR > 1 { if ($1 > prev) count++ }
{ prev = $1 }
END { print count }
