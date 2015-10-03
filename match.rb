u1 = 0
u2 = 0

s = gets.chomp.split(" ")

number_of_users = s[0].to_i
number_of_query = s[1].to_i

user = Array.new(number_of_users)

for i in 0..(number_of_users-1) do
    user[i] =Array.new(number_of_users, 0)
end

for i in 0..(number_of_users-1) do
    user[i][i] = 1
end

query = Array.new(number_of_query)

for i in 0..(number_of_query-1) do
    query[i] = Array.new(3)
end

for i in 0..(number_of_query-1) do
    t = gets.chomp.split(" ")
    query[i][0] = t[0].to_i
    query[i][1] = t[1].to_i
    query[i][2] = t[2].to_i
end

for i in 0..(number_of_query-1) do
    
    if query[i][0].to_i == 0
        u1 = query[i][1].to_i - 1
        u2 = query[i][2].to_i - 1
        
        user[u1][u2] = 1
        user[u2][u1] = 1
        
        for j in 0..(number_of_users-1)
            if user[u1][j] == 1 && j != u2
                user[u2][j] =1
                
                for k in 0..(number_of_users-1) do
                    if user[u2][k] == 1
                        user[j][k] = 1
                    end
                end
            end
        end
            
        for j in 0..(number_of_users-1)
            if user[u2][j] == 1 && j != u1
                user[u1][j] = 1
                for k in 0..(number_of_users-1) do
                    if user[u1][k] == 1
                        user[j][k] = 1
                    end
                end
            end
        end
        
        u1 = 0
        u2 = 0
        
        #for j in 0..(number_of_users-1)
        #    p user[j]
        #end
        
    elsif query[i][0].to_i == 1
        u1 = query[i][1].to_i - 1
        u2 = query[i][2].to_i - 1
        
        if user[u1][u2] == 1
            puts "yes"
        elsif user[u1][u2] == 0
            puts "no"
        end
    end
end
