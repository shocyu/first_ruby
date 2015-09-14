s = gets.chomp.split(" ")

x = s[0].to_i
y = s[1].to_i
z = s[2].to_i


t = Array.new((x*z)+3)
u = Array.new(z)
for i in 0..(z-1) do
    u[i] = Array.new(x+1, ".")
end

count = Array.new(z)
for i in 0..(z-1) do
    count[i] = Array.new(x+1, 0)
end

max = Array.new(z, 0)

for i in 0..((x*z)+z) do
    t[i] = gets.to_s
end

for i in 0..(x-1) do
    u[0][i] = t[i]
end

for i in 1..(z-1) do
    for j in 0..(x-1) do
        u[i][j] = t[(i*x)+j+i]
    end
end

for i in 0..(z-1) do
    for j in 0..(x-1) do
        for k in 0..(y-1) do
            if u[i][j][k] != "#"
                count[i][j] = k
            end
            
            if k == y-1
                count[i][k] = y
            end
        end
    end
end

for i in 0..(z-1) do
    for j in 0..(x-1) do
        if count[i][j] > max[i]
            max[i] = count[i][j]
        end
        
    end
end

(z-1).downto(0) do |i|
    for j in 0..(max[i]-1)
        print "#"
    end
    (max[i]).upto(y) do |j|
        print "."
    end
    print "/n"
end