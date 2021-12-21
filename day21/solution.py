from functools import cache


with open("input.txt") as inputfile:
    p1start, p2start = [int(line.split()[-1]) for line in inputfile]


def part1dice():
    while True:
        for i in range(100):
            yield 6 + 9 * i

dice = part1dice()
scores = [0, 0]
positions = [p1start, p2start]
rolls = 0
while True:
    player = rolls % 2
    positions[player] = (positions[player] + next(dice) - 1) % 10 + 1
    scores[player] += positions[player]
    rolls += 1
    if max(scores) >= 1000: break
print(3 * rolls * min(scores))


# Part 2
@cache
def part2(pos_p1, pos_p2, score_p1, score_p2):
    if score_p1 >= 21: return (1, 0)
    if score_p2 >= 21: return (0, 1)
    p1wins, p2wins = 0, 0
    for roll in (d1 + d2 + d3 for d1 in (1,2,3) for d2 in (1,2,3) for d3 in (1,2,3)):
        next_pos = (pos_p1 + roll - 1) % 10 + 1
        w2, w1 = part2(pos_p2, next_pos, score_p2, score_p1 + next_pos)
        p1wins += w1
        p2wins += w2
    return (p1wins, p2wins)

p1wins, p2wins = part2(p1start, p2start, 0, 0)
print(max(p1wins, p2wins))
