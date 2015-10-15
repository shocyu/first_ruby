check = 0
sum = 0
pos = 0

s = gets.chomp.split(" ")

d = s[0].to_i
n = s[1].to_i

dist = Array.new(n, 0)
lr = Array.new(n)

for i in 0..(n - 1) do
    dist[i] = gets.to_i
end

check = 10

lr[0] = "R"
sum = dist[0]
pos = dist[0]

i += 1

while i < n do
    if ( sum + dist[i] ) <= check
        lr[i] = lr[i - 1]
        sum = sum + dist[i]
        if lr[i] == "R"
            pos = pos + dist[i]
        else
            pos = pos - dist[i]
        end
        
        i += 1
    else
        if dist[i - 1] + dist[i] > check
            if lr[i - 1] == "R"
            sum = dist[i]
            lr[i - 1] = "L"
            lr[i] = "R"
            pos = pos - dist[i - 1] + dist[i]
            check = 10 + pos.abs
            i += 1
            else
            sum = dist[i]
            lr[i - 1] = "R"
            lr[i] = "L"
            pos = pos + dist[i-1] - dist[i]
            check = 10 + pos.abs
            i += 1
            end
        else
        check = 10 + pos.abs
        if lr[i - 1] == "R"
            sum = dist[i]
            lr[i] = "L"
            pos = pos - dist[i]
            i += 1
        else
            sum = dist[i]
            lr[i] = "R"
            pos = pos + dist[i]
            i += 1
        end
        end
    end
end

for i in 0..(n - 1) do
    print lr[i].to_s
end

print "\n"