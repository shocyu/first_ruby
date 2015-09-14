s = gets.to_s

score = 0

pair = Array.new(2)



if (s[0] == s[1]) && (s[0] == s[2]) && (s[0] == s[3])
    score = 4
end

if (s[0] == s[1] && s[0] == s[2] && s[0] != s[3]) || (s[0] == s[1] && s[0] == s[3] && s[0] != s[2]) || (s[0] == s[2] && s[0] == s[3] && s[0] != s[1]) || (s[1] == s[2] && s[1] == s[3] && s[0] != s[1])
    score = 3
end

puts score.to_s

if (score != 4) && (score != 3)
    for i in 0..3 do
        for j in (i+1)..3 do
            if s[i]  == s[j]
                pair[0] = i
                pair[1] = j
                score = 1
                puts score.to_s
                break
            end
        end
    end
end

if score == 1
    for i in 0..3 do
        for j in (i+1)..3 do
            if i != pair[0] && i != pair[1]
                if j != pair[0] && i != pair[1]
                    if s[i]  == s[j]
                        score = 2
                        puts score.to_s
                        break
                    end
                end
            end
        end
    end
end

if score == 3
    for i in 0..3 do
        if s[i] == "*"
            score = 4
            puts score.to_s
            break
        end
    end
end

if score == 1
    for i in 0..3 do
        if s[i] == "*"
            score = 3
            puts score.to_s
            break
        end
    end
end

if score == 0
    for i in 0..3 do
        if s[i] == "*"
            score = 1
            puts score.to_s
            break
        end
    end
end

case score
    when 4
        puts "FourCard"
    when 3
        puts "ThreeCard"
    when 2
        puts "TwoPair"
    when 1
        puts "OnePair"
    else
        puts "NoPair"
end