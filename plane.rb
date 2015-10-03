time = 0

N = gets.to_i

start = Array.new(N)
position = Array.new(N)

footstep = Array.new(500)

for i in 0..499 do
    footstep[i] = Array.new(2)
end

for i in 0..(N-1)
    start[i] = Array.new(2)
end

for i in 0..(N-1)
    position[i] = Array.new(2)
end

for i in 0..(N-1) do
    s = gets.chomp.split(" ")
    start[i][0] = s[0]
    start[i][1] = s[1]
end

