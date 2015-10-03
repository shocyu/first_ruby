count = 0
max = 0

x_limit = 0.0

N = gets.to_i

circle = Array.new(N)
limit = Array.new(N)

for i in 0..(N-1)
    circle[i] = Array.new(3, 0.0)
end

for i in 0..(N-1)
    limit[i] = Array.new(2, 0.0)
end

for i in 0..(N-1) do
    s = gets.chomp.split(" ")
    circle[i][0] = s[0].to_f
    circle[i][1] = s[1].to_f
    circle[i][2] = s[2].to_f
end

circle.sort!

for i in 0..(N-1) do
    if circle[i][2] < circle[i][1]
        limit[i][0] = 20000.0
        limit[i][1] = 20000.0
    else
        limit[i][0] = circle[i][0] - Math.sqrt( (circle[i][2]**2)-(circle[i][1]**2) )
        limit[i][1] = circle[i][0] + Math.sqrt( (circle[i][2]**2)-(circle[i][1]**2) )
    end
end

limit.sort!
p limit

for i in 0..(N-1) do
    if limit[i][1] == 20000.0
        count = 0
        next
    else
        count = 1
        for j in (i+1)..(N-1) do
            if limit[j][0] <= limit[i][1]
                count += 1
                
                if limit[j][0] > x_limit
                    x_limit = limit[j][0]
                end
            end
            
            if limit[j][0] > limit[i][1]
                break
            end
        end
        
        if count > max
                max = count
        end
    end
end

puts max