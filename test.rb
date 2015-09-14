# 自分の得意な言語で
# Let's チャレンジ！！

s = gets.chomp.split(" ")

L = s[0].to_i   #線の長さ
n = s[1].to_i   #縦線の本数
m = s[2].to_i   #横線の本数

#横線情報を格納する配列の作成
t = Array.new(m)
u = Array.new(m)

0.upto(m-1) do |i|
    u[i] = Array.new(3, 0)
end
#配列 t,u作成

#分岐点と行先を入力する配列の作成
node = Array.new(L+1)

0.upto(L+1) do |i|
    node[i] = Array.new(n, 0)
end
#node配列

#横線入力情報の読み込み
0.upto(m-1) do |i|
    t[i] = gets.chomp.split(" ")
end

#横線入力情報を数値型配列に置き換え
0.upto(m-1) do |i|
    0.upto(2) do |j|
        u[i][j] = t[i][j].to_i
    end
end

#配列 u(横線情報)、から node　配列へ情報の移し替え
0.upto(m-1) do |i|
    node[ u[i][1] ][ u[i][0]-1 ] = u[i][2]
    node[ u[i][2] ][ u[i][0] ] = -u[i][1]
end

#ゴールのいちばん左からスタートへたどり着くループ
#ループ初期化
i = L   #縦位置の上から何cm か(いちばん下が L)  
j = 0   #何番目の縦線か(いちばん左は０ 
print "i,j ="+ i.to_s + "," + j.to_s + "\n"

#ループ開始
while i != 0

    if node[i][j] != 0  #node 配列に情報がある場合（０でない場合)
        if node[i][j] > 0
            i = node[i][j]  #横線を node 配列の示す（縦線の）位置へ
            j = j+1     #縦線を右へ
            i -= 1
            print "i,j ="+ i.to_s + "," + j.to_s + "\n"
        elsif node[i][j] < 0
            i = -(node[i][j])   #横線をnode 配列の示す（縦線の）位置へ
            j = j-1         #縦線を左へ
            i -= 1
            print "i,j ="+ i.to_s + "," + j.to_s + "\n"
        end
    else
        i -= 1
        print "i,j ="+ i.to_s + "," + j.to_s + "\n"
    end
    
end

j += 1
puts j.to_s