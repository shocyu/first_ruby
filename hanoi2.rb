#プログラム読み込み開始時間を表示
start_time = Time.now


#direct メソッド
# 引数（コマの番号、スタート位置、ゴール位置）
# ３列の配列を生成し、その配列を返す
def direct(piece, start, goal)
    ar2 = Array.new(1)
    ar2[0] = Array.new(3)
    
    ar2[0][0] = piece
    ar2[0][1] = start
    ar2[0][2] = goal
    
    return ar2
end
# direct メソッド終わり

# hanoi メソッド（コマ番号、スタート、と行先を格納した配列を返すメソッド）
# 引数（コマ番号、スタート位置、ゴール位置）
# ３列の配列を生成し、その配列を返す。
def  hanoi(piece, start, goal)
    
    start1 = 0
    goal1 = 0
    
    start1 = start
    goal1 = goal
    
    ar1 = Array.new
    
    # stack （間の位置）を決定（start = 1, goal = 3　ならば、stack = 2)
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
        
    # コマの番号が２になった場合
    # いちばん基本の組み合わせ（ここから元をたどって、最後にすべての答えが入った配列が返される）
    if piece <= 2
        i = 0
        ar = Array.new(3)
    
        for i in 0..2 do
            ar[i] = Array.new(3)
        end
        
        ar[0][0] = piece - 1
        ar[0][1] = start
        ar[0][2] = stack
        
        ar[1][0] = piece
        ar[1][1] = start
        ar[1][2] = goal
        
        ar[2][0] = piece - 1
        ar[2][1] = stack
        ar[2][2] = goal
        
        return ar    # 値が格納された配列を返す
    else
        
        # 再帰的呼び出し
        # １つ前のコマの状態を呼び出し、それを元に自分自身の配列を形作る
        # 真ん中に　direct メソッドによって生成された配列を入れている
        ar1 = hanoi((piece - 1), start1, stack) + direct(piece, start1, goal1) + hanoi((piece - 1), stack, goal1)
        return ar1
    end
end
# hanoi メソッド終わり

#実際の処理（メインの処理）

# 最初にコマの数を入力（n = コマの数）
puts "Number of Pieces"
n = gets.to_i

# 答えを格納する配列を生成（最初は大きさを決めないでおく）
ar3 = Array.new

# 最初の hanoi メソッド呼び出し（それ以降、順次 hanoi メソッド内で次の hanoi メソッドが呼び出される（再帰的呼び出し）　）
ar3 = hanoi(n, 1, 3)

max = ar3.size

# 答えを最初から出力（ar3[]　配列を用いて）
for i in 0..(max - 1) do
    puts "No." + (i+1).to_s + ", piece" + ar3[i][0].to_s + ", from" + ar3[i][1].to_s + ", to" + ar3[i][2].to_s
end

# 実行時間を出力
p "Processing Time #{Time.now - start_time}s"