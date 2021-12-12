input = File.open('input.txt').read.split

cavemap = Hash.new{|h,k|h[k]=[]}

input.each do |line|
    a, b = line.split('-')
    cavemap[a] << b
    cavemap[b] << a
end

def small?(cave) = cave.match?(/^[a-z]+/)

def countpaths(graph, visited, from, to)
    return 1 if from == to
    return 0 if visited.include?(from)
    graph[from].sum do |dest|
        countpaths(graph, visited + (small?(from) ? [from] : []), dest, to)
    end
end

def countpaths2(graph, doubled, visited, from, to)
    return 1 if from == to
    if visited.include?(from)
        return 0 if doubled || from == 'start'
        doubled = true
    end
    graph[from].sum do |dest|
        countpaths2(graph, doubled, small?(from) ? visited + [from] : visited, dest, to)
    end
end

# Part 1
puts countpaths(cavemap, [], 'start', 'end')

# Part 2
puts countpaths2(cavemap, false, [], 'start', 'end')
