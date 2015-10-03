days = 0
flag = 0

s = gets.chomp.split(" ")

n = s[0].to_i
m = s[1].to_i

parade = Array.new(n, 0)

number = Array.new(m, 0)

for i in 0..(m-1) do
    number[i] = gets.to_i
end

for i in 1..(Math.log2(m)-1) do
    
    for j in 0..(m - (m / (2**i))-1 ) do
        flag = 0
        
        for k in 0..(n-1) do
            parade[k] = 0
        end
        
        for k in 0..( (m / (2**i))-1 ) do
            if parade[number[j+k]-1] == 0
                parade[number[j+k]-1] = 1
            end
        end
        
        for l in 0..(n-1) do
            if parade[j] == 0
                flag = 1
                break
            end
        end
        
        if flag == 0
            break
        else
            next
        end
    end
    
    p parade
    
    if flag == 0
        next
    else
        power = i
        puts power
        break
    end
end

flag = 0

for i in ( (m / (2**power)) - 1)..( (m / (2**(power-1)) ) - 1) do
    
    for j in 0..(m-i-1) do
        flag = 0
        
        for k in 0..(n-1) do
            parade[k] = 0
        end
        
        for k in 0..i do
            if parade[number[j+k]-1] == 0
                parade[number[j+k]-1] = 1
            end
        end
        
        for l in 0..(n-1) do
            if parade[j] == 0
                flag = 1
                break
            end
        end
        
        if flag == 1
            next
        else
            break
        end
    end
    
    puts i
    puts flag
    p parade
    
    if flag == 0
        days = i+1
        break
    end
end

puts days.to_s