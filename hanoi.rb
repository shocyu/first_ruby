#３本のポール番号の初期化（stackは間に入るポール）
start = 0
goal = 0
stack = 0

#move配列のインデックスを指定するパラメータ
u = 0
v = 0
x = 0

#入力情報の取り込み（コマの個数）
n = gets.to_i



#最小試行回数（2^n -1  回）
max = (2 ** n) - 1

#コマの移動を示す配列(move配列,2次元)
move = Array.new(max)

0.upto(max-1) do |i|
    move[i] =Array.new(3, 0)
end

#move配列の最初の配置(ｎ番目（ラスト)のコマを１から３へ）
move[(2 ** (n-1))-1] = [n, 1, 3]

#(n-1)番目以降の move （移動）の配置
for i in 1..(n-1) do
    
    for j in 0..((2 ** (i-1))-1) do
        u = (2 ** (n-i)) - 1
        v = (2 ** (n-i-1)) - 1
        x = ( ((2*(j+1)) - 1) * ((2 ** (n-i)) - 1) ) + (2*(j+1)) - 2
        
        #puts "i,j = " + i.to_s + "," + j.to_s
        #puts "u,v,x = " + u.to_s + "," + v.to_s + "," + x.to_s
        
        start = move[x][1]
        goal = move[x][2]
        
        if start == 1 && goal ==2
            stack = 3
        elsif start == 1 && goal ==3
            stack = 2
        elsif start == 2 && goal ==1
            stack =3
        elsif start == 2 && goal ==3
            stack = 1
        elsif start == 3 && goal ==1
            stack = 2
        elsif start == 3 && goal ==2
            stack = 1
        end
        
        #puts "start,goal,stack = " + start.to_s + "," + goal.to_s + "," + stack.to_s
        
        move[x-v-1][0] = n - i
        move[x-v-1][1] = start
        move[x-v-1][2] = stack

        move[x+v+1][0] = n - i
        move[x+v+1][1] = stack
        move[x+v+1][2] = goal
    end
end

0.upto(max-1) do |i|
    puts "No." + (i+1).to_s + ", piece" + move[i][0].to_s + ", from" + move[i][1].to_s + ", to" + move[i][2].to_s
end