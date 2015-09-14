# 自分の得意な言語で
# Let's チャレンジ！！
game = Array.new(21, 0)
score = Array.new(21, 0)
total = 0

s = gets.chomp.split(" ")

frame = s[0].to_i
pin = s[1].to_i
number= s[2].to_i

n = 2*(frame-1) + 3

p = pin.to_s

t = gets.chomp.split(" ")

j = 0

#投球した情報を整理
for i in 0..(n-1) do
    if (t[i] == p) && (j % 2 ==0) && (j < (2*(frame-1)) ) #奇数回の番号で”１０”（ストライク）の場合
        game[j] = pin
        game[j+1] = 0
        j = j+2
    elsif (t[i] == "G")
        game[j] = 0
        j += 1
    else
        game[j] = t[i].to_i
        j += 1
    end
end

p game.to_s

#各スコアを計算（９フレームまで）
for i in 0..(2*(frame-1)-1) do
    if (game[i] == pin) && (i % 2 ==0) #奇数回の番号で”１０”（ストライク）の場合
        if (game[i+2] == pin) && ((i+2) < 2*(frame-1))
            score[i] = game[i] + game[i+2] + game[i+4]
        elsif ( (game[i+2]) == pin ) && ( (i+2) >= (2*(frame-1)) )
            score[i] = game[i] + game[i+2] + game[i+3]
        else
            score[i] = game[i] + game[i+2] + game[i+3]
        end
    elsif (i % 2 == 1) && (game[i-1]+game[i] == pin) && (game[i] != 0)
        score[i] = game[i] + game[i+1]
    else
        score[i] = game[i]
    end
end

    if game[2*(frame-1)] == pin
        score[2*(frame-1)] = game[2*(frame-1)] + game[2*(frame-1)+1] + game[2*frame]
    else
        score[2*(frame-1)] = game[2*(frame-1)]
    end
    
    if game[2*(frame-1)+1] == pin
        score[2*(frame-1)+1] = game[2*(frame-1)+1] + game[2*frame]
    elsif (game[2*(frame-1)]+game[2*(frame-1)+1]) == pin
        score[2*(frame-1)+1] = game[2*(frame-1)+1] + game[2*frame]
    else
        score[2*(frame-1)+1] = game[2*(frame-1)+1]
    end

if (game[2*(frame-1)]+game[2*(frame-1)+1]) >= pin
    score[2*frame] = game[2*frame]
else
    score[2*frame] = 0
end

for i in 0..(n-1) do
    total += score[i]
end

p score.to_s

puts total.to_s