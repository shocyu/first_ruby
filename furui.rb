ans = Array.new(10, 0)
s = Array.new(10)

for i in 0..9 do
    s[i] = gets
end

for i in 0..9 do
    
    max = s[i].to_i

    list = Array.new(max - 1, 1)
    sq = Math.sqrt(max).floor

    for j in 2..sq do
        if list[j - 1] == 1
            pow = j * j
        
            while pow < max
                list[pow - 1] = 0
                pow = pow + j
            end
        end
    end

    for j in 1..(max - 2) do
        if list[j] == 1
            ans[i] += 1
        end
    end

end

for i in 0..9 do
    puts ans[i].to_s
end