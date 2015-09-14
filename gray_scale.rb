rate = 0

s = gets.chomp.split(" ")

width = s[0].to_i
downsize = s[1].to_i

rate = width / downsize

t = Array.new(width)
pixel = Array.new(width)
block = downsize * downsize

for i in 0..(width-1) do
    t[i] = gets.chomp.split(" ")
end

for i in 0..(width-1) do
    pixel[i] = Array.new(width, 0)
end

for i in 0..(pixel-1) do
    for j in 0..(pixel-1) do
    pixel[i][j] = t[i][j].to_i
    end
end

gray = Array.new(rate)

for i in 0..(rate-1) do
    gray[i] = Array.new(rate, 0)
end

for i in 0..(rate-1) do
    for j in 0..(rate-1) do
    
        for p in 0..(downsize-1) do
            for q in 0..(downsize-1) do
                gray[i] +=pixel[(i*rate)+p][(j*rate)+q]
            end
        end
    end
end

for i in 0..(rate-1) do
    for j in 0..(rate-1) do
        gray[i][j] = gray[i][j] / block
    end
end

for i in 0..(rate-1) do
    for j in 0..(rate-2) do
        print gray[i][j] + " "
    end
    print gray[i][rate-1]
    print "\n"
end
end

