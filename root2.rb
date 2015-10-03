#答えを格納する変数（float 型）
answer = 0.0

# root2_fraction メソッド
#連分数展開の処理を n 回行うメソッド
def root2_fraction(n)
  a = 0.0 

  # n が１ならば、最小単位（ = 5/2 )を返す
  if n <= 1
    a = 2.5
  # n が１より大きければ、いちばん分母に同じメソッドを入れ込む（再帰的処理）
  else
    a = (2 + (1 / root2_fraction(n - 1) ) ).to_f
  end

  return a    #処理を繰り返した結果を返す
end
# root2_fraction メソッド終わり

#処理を繰り返す回数を入力（N)
puts "How many times?"
N = gets.to_i
puts "\n"

# １回から N回処理を実行した結果を出力
for i in 1..N do

  answer = 1.0 + (1 / root2_fraction(i) )
  puts answer.to_s

  answer = 0.0    # answer の値を初期化
end