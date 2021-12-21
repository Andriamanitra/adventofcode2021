from functools import cache


with open("input.txt") as inputfile:
    p1start, p2start = [int(line.split()[-1]) for line in inputfile]


def part1dice():
    while True:
        for i in range(100):
            yield 6 + 9 * i

dice = part1dice()
score_p1 = 0
score_p2 = 0
pos_p1 = p1start
pos_p2 = p2start
rolls = 0
while True:
    rolls += 1
    pos_p1 = (pos_p1 + next(dice) - 1) % 10 + 1
    score_p1 += pos_p1
    if score_p1 >= 1000: break
    rolls += 1
    pos_p2 = (pos_p2 + next(dice) - 1) % 10 + 1
    score_p2 += pos_p2
    if score_p2 >= 1000: break
print(3 * rolls * min(score_p1, score_p2))


# Part 2
@cache
def part2(pos_p1, pos_p2, score_p1, score_p2, t):
    if t: return tuple(reversed(part2(pos_p2, pos_p1, score_p2, score_p1, not t)))
    if score_p1 >= 21: return (1, 0)
    if score_p2 >= 21: return (0, 1)
    a = 0
    b = 0
    for roll in (d1 + d2 + d3 for d1 in (1,2,3) for d2 in (1,2,3) for d3 in (1,2,3)):
        next_pos = (pos_p1 + roll - 1) % 10 + 1
        an, bn = part2(next_pos, pos_p2, score_p1 + next_pos, score_p2, not t)
        a += an
        b += bn
    return (a, b)

p1wins, p2wins = part2(p1start, p2start, 0, 0, False)
print(max(p1wins, p2wins))
