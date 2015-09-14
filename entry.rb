s = gets.chomp.split(" ")

a_walk = s[0].to_i
b_train = s[1].to_i
c_walk = s[2].to_i

N = gets.to_i
leave_home = 0
leave_home_to_60 = Array.new(2, 0)
number = 0

t = Array.new(N)
u = Array.new(N)
for i in 0..(N-1) do
    u[i] = Array.new(2, 0)
end

leave_st1 = Array.new(N, 0)
arrive_st2 = Array.new(N, 0)
leave_st2 = (8*60)+59 -c_walk

for i in 0..(N-1) do
    t[i] = gets.chomp.split(" ")
end

for i in 0..(N-1) do
    for j in 0..1 do
    u[i][j] = t[i][j].to_i
    end
end

for i in 0..(N-1) do
    leave_st1[i] = 60*u[i][0] + u[i][1]
    puts leave_st1[i]
end

for i in 0..(N-1) do
    arrive_st2[i] = leave_st1[i] + b_train
end

(N-1).downto(0) do |i|
    if arrive_st2[i] <= leave_st2
        number = i
        break
    end
end

leave_home = leave_st1[number] -a_walk
leave_home_to_60[0] = leave_home / 60
leave_home_to_60[1] = leave_home % 60

print "0"+ leave_home_to_60[0].to_s + ":" + leave_home_to_60[1].to_s + "\n"
        