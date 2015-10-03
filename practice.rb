sort = Array.new
stack = Array.new
rest = Array.new(4, 0)

n = 0
m = 0
max = 0
max_number = 0

x = 0

s = gets.chomp.split(" ")

N = s[0].to_i
M = s[1].to_i

practice = Array.new(N)
skill = Array.new(M)

for i in 0..(N-1) do
    practice[i] = Array.new(4)
end

for i in 0..(M-1) do
    skill[i] = Array.new(4)
end

for i in 0..(N-1) do
    s = gets.chomp.split(" ")
    practice[i][0] = s[0].to_i
    practice[i][1] = s[1].to_i
    practice[i][2] = s[2].to_i
    practice[i][3] = s[3].to_i
end

for i in 0..(M-1) do
    s = gets.chomp.split(" ")
    skill[i][0] = s[0].to_i
    skill[i][1] = s[1].to_i
    skill[i][2] = s[2].to_i
    skill[i][3] = s[3].to_i
end

for i in 0..(M-1) do
    
    n = 0
    max_number = 0
    max = 0
    
    for j in 0..3
        rest[j] = skill[i][j]
    end

    while ((rest[0] != 0) || (rest[1] != 0) || (rest[2] != 0) || (rest[3] != 0) )
    
        max = 0
        max_number = 0
    
        for j in 0..3 do
            if rest[j] > max
                max_number = j
                max = rest[j]
            end
        end
        
        sort = practice.sort { |a, b| b[max_number] <=> a[max_number] }
        stack = sort[0].push
        m = stack.size
        x = m-1
        
        for j in 0..(x) do
            for k in 0..3 do
                if rest[k] == 0
                    next
                elsif stack[j][k] > rest[k]
                    rest[k] = 0
                else
                    rest[k] = rest[k] - stack[j][k]
                end
            end
        end
        
        n += 1
    end
    
    puts n.to_s
end