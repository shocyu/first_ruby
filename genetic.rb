
#------------------------------------------------------------------------------------#
#Geneticsクラス（genesの生成と、交叉）
class Genetics

#インスタンス変数 genes, value, evaluation は参照と変更可能
attr_accessor :genes
attr_accessor :value
attr_accessor :evaluation
attr_accessor :reciprocal

#コンストラクタ（インスタンス変数 @genes, @value, @evaluation, @reciprocal生成)
def initialize(number_of_genes, max_value, overwrap)
  @genes = Array.new(number_of_genes, 0)    #genes配列（遺伝情報を格納する配列）
  @value = Array.new(number_of_genes, 0.0)    #value配列（遺伝情報に基づく値（表現型の情報））
  @evaluation = 1.0    #value配列に基づき、各個体の評価関数の値（適合度）を格納
  @reciprocal = 0.0    #評価関数の値（evaluation)の逆数を格納（評価関数が少ないほど良い場合に用いる）

  #重複を認める場合、ランダムに遺伝情報を生成
  if overwrap == 0
    for i in 0..(number_of_genes-1) do
      @genes[i] = Random.rand(max_value * 10) % max_value
    end
  #重複を認めない場合、遺伝情報の分だけ値をシャッフルして生成
  else
    for i in 0..(number_of_genes-1) do
      @genes[i] = i
    end

    @genes.shuffle!
  end

end

#crossメソッド(２つの親の遺伝情報を交叉、１点交叉）
def cross(other, child1, child2, number_of_genes, max_value, overwrap, cross)

  index = 0
  division = number_of_genes / (cross+1)

  #重複を認める場合
  if overwrap == 0
    stack = 0

    #cross（交叉点数により交叉する、しないの区別）
    for i in 0..(cross) do

      #i が偶数（０を含む）の遺伝情報は親をそのまま引き継ぐ
      if (i != cross)  && ( ( i / 2 ) == 0 )
        for j in (division * i)..( (division * (i+1)) -1 ) do
          child1.genes[j] = self.genes[j]
          child2.genes[j] = other.genes[j]
        end

      #i が奇数の場合は遺伝情報を交換
      elsif (i != cross) && ( ( i / 2 ) != 0)
        for j in (division * i)..( (division * (i+1)) -1 ) do
          child1.genes[j]= other.genes[j]
          child2.genes[j] = self.genes[j]
        end

      #iが偶数（０を含む）でかつラスト（ラストまで交換なし）
      elsif (i == cross)  && ( ( i / 2 ) == 0)
        for j in (division * i)..( number_of_genes -1 ) do
          child1.genes[j] = self.genes[j]
          child2.genes[j] = other.genes[j]
        end

      #i が奇数でかつラスト（ラストまで交換）
      elsif (i == cross) && ( ( i / 2 ) != 0)
        for j in (division * i)..(number_of_genes-1) do
          child1.genes[j]= other.genes[j]
          child2.genes[j] = self.genes[j]
        end

      end    #if文終わり

      #突然変異（各個体について、１つの遺伝子を書き換え）
      index = Random.rand(number_of_genes * 10) % number_of_genes
      child1.genes[index] = Random.rand(max_value)
      child2.genes[index] = Random.rand(max_value)
      #puts "index = " + index.to_s
    end

  #重複を認めない場合
  else
    stack = 0

    one_to_two = 0
    two_to_one = 0

    #親から子へそのままコピー
    for i in 0..(number_of_genes-1) do
      child1.genes[i] = self.genes[i]
      child2.genes[i] = other.genes[i]
    end

    for i in 0..cross do

      #交差点が偶数で crossの値が（ラスト）でない場合はそのまま
      if (i != cross) && ( (i / 2) == 0 )
        next

      #交差点が奇数で crossの値が（ラスト）でない場合は遺伝情報を交換
      elsif ( i != cross) && ( (i / 2) != 0 )
        for j in (division * i)..( (division * (i+1)) -1 ) do
          one_to_two = child1.genes[j]
          two_to_one = child2.genes[j]

          if child1.genes[j] == child2.genes[j]
            child1.genes[j] = two_to_one
            child2.genes[j] = one_to_two
          else
            #2つの個体の遺伝情報が異なる場合、各個体間で入れ替え（重複を避けるため）
            for k in 0..(number_of_genes-1) do
              if child1.genes[k] == two_to_one && (k != j)
                child1.genes[k] = child1.genes[j]
                child1.genes[j] = two_to_one
                break
              end
            end

            for k in 0..(number_of_genes-1) do
              if child2.genes[k] == one_to_two && (k != j)
                child2.genes[k] = child2.genes[j]
                child2.genes[j] = one_to_two
                break
              end
            end

          end    #if文終了（遺伝情報が同じかどうかの判定）
        end    #for文終了（遺伝情報の交換）

      #交差点が偶数で cross（ラスト）の場合はループ終了
      elsif (i == cross) && ( (i / 2) == 0 )
        break

      #交差点が奇数で cross（ラスト）の場合は最後（number_of_genes -1)まで遺伝情報を交換
      elsif (i == cross) && ( (i / 2) != 0 )
        for j in (division * i)..( number_of_genes -1 ) do
          one_to_two = child1.genes[j]
          two_to_one = child2.genes[j]

          if child1.genes[j] == child2.genes[j]
            child1.genes[j] = two_to_one
            child2.genes[j] = one_to_two
          else
            #2つの個体の遺伝情報が異なる場合、各個体間で入れ替え（重複を避けるため）
            for k in 0..(number_of_genes-1) do
              if child1.genes[k] == two_to_one && (k != j)
                child1.genes[k] = child1.genes[j]
                child1.genes[j] = two_to_one
                break
              end
            end

            for k in 0..(number_of_genes-1) do
              if child2.genes[k] == one_to_two && (k != j)
                child2.genes[k] = child2.genes[j]
                child2.genes[j] = one_to_two
                break
              end
            end

          end    #if文終了（遺伝情報が同じかどうか判定）
        end    #for文終了 (遺伝情報の交換）

      end    #if文終了 (crossが偶数か奇数か)
    end    #for文終了（cross＝交叉点数の分だけ）

    #突然変異（各個体について、１つの遺伝子を書き換え）
    index = Random.rand(number_of_genes * 10) % number_of_genes
    stack = child1.genes[index]
    child1.genes[index] = Random.rand(max_value)

    for j in 0..(number_of_genes-1) do
      if child1.genes[j] == stack && (j != index)
        child1.genes[j] = stack
        break
      end
    end

    index = Random.rand(number_of_genes * 10) % number_of_genes
    stack = child2.genes[index]
    child2.genes[index] = Random.rand(max_value)

    for j in 0..(number_of_genes-1) do
      if child2.genes[j] == stack && (j != index)
        child2.genes[j] = stack
        break
      end
    end

    stack = 0
    index = 0

  end    #overwrapによる場合分け終了
end    #crossメソッド終了

end
#Geneticクラス定義ここまで
#---------------------------------------------------------------------------------#

#---------------------------------------------------------------------------------#
#Make_Individualクラス（parent,childなどの集団の生成とランク付け、淘汰を行うクラス）
class Make_Individual

#インスタンス変数 individuals は参照と変更可能
attr_accessor :individuals

#コンストラクタ（インスタンス変数 @individuals(parentの集団、または child の集団）生成)
def initialize(number_of_individuals, number_of_genes1, max_value1, overwrap1)

  @individuals = Array.new(number_of_individuals)

  #個々の個体をGeneticsクラスによって定義（各個体は遺伝情報、表現型、評価関数（適合度）の各情報を持つ）
  for i in 0..(number_of_individuals-1) do
    @individuals[i] = Genetics.new(number_of_genes1, max_value1, overwrap1)
  end
end

#cross_individualメソッド（parentからchildへの集団全体の交叉－Geneticsクラスの、crossメソッド使用）
def cross_individual(other, number_of_genes1, max_value1, overwrap1, cross1)
  for j in 0..( (NI / 2)-1 ) do
    self.individuals[2*j].cross(self.individuals[(2*j)+1], other.individuals[2*j], other.individuals[(2*j)+1], number_of_genes1, max_value1, overwrap1, cross1)
  end
end

#rankingメソッド（交叉によって生まれたchild群の評価関数(evaluation)によるランク付け)
def ranking(number_of_individuals, number_of_genes1, max_value1, overwrap1, better_ways)
  child_dummy = Genetics.new(number_of_genes1, max_value1, overwrap1)

  #評価関数（evaluation)が高いほど良い場合
  if better_ways == 0
    for i in 0..(number_of_individuals-2) do

      j = 0

      while (self.individuals[i-j+1].evaluation > self.individuals[i-j].evaluation) && ( (i-j) >= 0 )
        child_dummy = self.individuals[i-j]
        self.individuals[i-j] = self.individuals[i-j+1]
        self.individuals[i-j+1] = child_dummy

        j += 1
      end
    end

  #評価関数（evaluation)が低いほど良い場合
  else
    for i in 0..(number_of_individuals-2) do

      j = 0

      while (self.individuals[i-j+1].reciprocal > self.individuals[i-j].reciprocal) && ( (i-j) >= 0 )
        child_dummy = self.individuals[i-j]
        self.individuals[i-j] = self.individuals[i-j+1]
        self.individuals[i-j+1] = child_dummy

        j += 1
      end
    end

  end    #if文ここまで
end
#rankingメソッドここまで

#elimination メソッド（上位５０％を選別し、新しい世代(parent)を生成）
def elimination(other, ways_of_choice, number_of_individuals, better_ways)

  random_score = 0.0

  #選択方法によって場合分け
  case ways_of_choice

  # 0: ルーレット選択
  when 0
    for i in 0..(number_of_individuals-1) do

      random_score = Random.rand
      j = 0

      while random_score > ( (sum_of_evaluation(self, better_ways, j)) / (sum_of_evaluation(self, better_ways, ( (number_of_individuals / 2)-1)) ) )
        j += 1
      end

      other.individuals[i] = self.individuals[j]
    end
  end    #case文終わり

end
#eliminationメソッドここまで

#sum_of_evaluationメソッド（それぞれの個体の評価関数の和を取る）
def sum_of_evaluation(group, better1, number)

  # better_ways = high 評価関数の値が高いほど良い（適合度が高い）場合
  if better1 == 0

    sum = 0.0

    for i in 0..(number) do
      sum += group.individuals[i].evaluation
    end

    return sum

  # better_ways = low 評価関数の値が低いほど良い（適合度が高い）場合
  else
    sum = 0.0

    for i in 0..(number) do
      sum += group.individuals[i].reciprocal
    end

    return sum
  end    #if文終わり
end
#sum_of_evaluationメソッドここまで

#show_distributionメソッド（生成された新たな親の分布を表示、個体数が３２の倍数がよい）
def show_distribution(other, number_of_individuals)

  distribution = Array.new(16, 0)
  probability = Array.new(16, 0.0)

  block = 0
  block = number_of_individuals / 32

  for i in 0..15 do
    for j in 0..(block -1) do
      for k in 0..(number_of_individuals-1) do

        if self.individuals[k].evaluation == other.individuals[(block*i)+j].evaluation
          distribution[i] += 1          
        end

      end
    end
  end

  for i in 0..15 do
    probability[i] = distribution[i].to_f / number_of_individuals.to_f
  end

  for i in 0..15 do
    puts "p(child No." + (i+1).to_s + ") = " + probability[i].to_s
  end

end
#show_distribtionメソッドここまで

end
#Make_Individualクラスここまで
#----------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------#
#make_distanceメソッド（２点間の距離を求めるメソッド）
def make_distance(x1, x2, y1, y2)
  d_pow = 0.0
  d = 0.0

  d_pow = ( (x2 - x1)**2) + ( (y2-y1)**2)
  d = Math.sqrt(d_pow)
  return d
end
#----------------------------------------------------------------------------------#


#巡回セールスマン問題を解く

#基本情報の入力--------------------------------------------------------------------#
#遺伝子長（各個体の遺伝情報の数）の入力
puts "Number of genes"
NG = gets.to_i

#各遺伝情報の最大値（整数）を入力
puts "Maximum Value"
MV = gets.to_i

#個体数の入力
puts "Number of Individuals"
NI = gets.to_i

#交叉、淘汰する世代数の入力
puts "Generations"
Generation = gets.to_i

#遺伝情報の重複の可否
puts "Overwrap OK? Yes=0, No=1"
Over = gets.to_i

#交叉するポイント数の入力（１点交叉～多点交叉）
puts "Number of crossing points"
Cross = gets.to_i

#個体選択の方法（０：ルーレット式）
puts "Which ways of choice? 0:roulette"
Ways = gets.to_i

#評価関数の値、high=高いほど良い（適合度が高い）、low = 低いほど良い
puts "Which is better, high or low? (0:high, 1:low)"
Better = gets.to_i

#通過する点の数を入力（最低２点）
puts "Number of Points (>= 2)"
Points = gets.to_i

position = Array.new(Points)

#各点間の距離を格納する配列の生成
distance = Array.new(Points)
for i in 0..(Points-1) do
  distance[i] = Array.new(Points, 0.0)
end


#各点の座標を（x,y）入力（スペース区切り)
puts Points.to_s + "Positions, Let's Put(x _ y)"

#各点の座標を格納（position[i][0]をｘ座標、position[i][1]をｙ座標とする
for i in 0..(Points-1) do

  position[i] = Array.new(2)    #position配列（各点の座標を入力する）を生成

  s = gets.chomp.split(/ /)

  position[i][0] = s[0].to_f
  position[i][1] = s[1].to_f
end
#基本情報の入力終わり
#--------------------------------------------------------------------------------#


#--------------------------------------------------------------------------------#
#入力した各点間の距離を求める
for i in 0..(Points-2) do
  for j in (i+1)..(Points-1) do
    distance[i][j] = make_distance(position[i][0], position[j][0], position[i][1], position[j][1])
    distance[j][i] = distance[i][j]     # 0->1, 1->0 の距離は同じ
  end
end

#for i in 0..(Points-1) do
#  for j in 0..(Points-1) do
#    puts "distance " + i.to_s + "to " + j.to_s + "=" + distance[i][j].to_s
#  end
#end
#--------------------------------------------------------------------------------#

#親の個体を生成
parent = Make_Individual.new(NI, NG, MV, Over)

#子の個体を生成
child = Make_Individual.new(NI, NG, MV, Over)

#parent(親の個体）の遺伝情報の初期化
for i in 0..(NI-1) do

  #遺伝情報の最初と最後を０とする（出発点を同じにするため）
  parent.individuals[i].genes[0] = 0
  parent.individuals[i].genes[NG-1] = 0

  #---------------------------------------------------------------------------------#
    #各遺伝情報に上限を設ける
    #遺伝子長１０の場合、最初は０、次の上限は８（９－１）、その次は７（８－１）とする
    #最初は０の場合、２番目は [0, 1, 2, 3, 4, 5, 6, 7, 8]の９つの値から選べる
    #２番目に７を選んだ場合、次は残りの [0, 1, 2, 3, 4, 5, 6, 8]から選べる
    #遺伝情報との対応は　　　　　　　（ [0, 1, 2, 3, 4, 5. 6, 7]　）
  #---------------------------------------------------------------------------------#
  for j in 1..(NG-2) do
    parent.individuals[i].genes[j] = Random.rand(NG-j)
  end
end

actual_point = Array.new(NG-1, 0)

#generation（世代数）まで、交叉の繰り返し、value配列(距離を格納）の更新、それに基づく淘汰
for i in 0..(Generation-1) do

  for j in 0..(NI-1) do
    child.individuals[j].evaluation = 0.0
  end

  #or j in 0..(NI-1) do
  #  puts "parent " + (j+1).to_s + "="
  #  p parent.individuals[j].genes
  #end

  #世代交叉（巡回セールスマン問題でも重複ＯＫ）
  parent.cross_individual(child, NG, MV, Over, Cross)

  for j in 0..(NI-1) do
    for k in 1..(NG-2) do
      if child.individuals[j].genes[k] >= NG-k
        child.individuals[j].genes[k] = Random.rand(NG-k)
      end      
    end

    if child.individuals[j].genes[0] != 0
      child.individuals[j].genes[0] = 0
    end

    if child.individuals[j].genes[NG-1] != 0
      child.individuals[j].genes[NG-1] = 0
    end
  end

  #遺伝情報を基に、value配列(表現型）の値（各点間の距離）を格納
  for j in 0..(NI-1) do

    #順序を格納する配列（遺伝情報より表現型の情報を取り出す際に使用）
    order = Array.new(NG-1)
    actual_point[0..(NG-1)] = 0

    n1 = 0
    n2 = 0

    for k in 0..(NG-1) do
      order[k] = k
    end

    for k in 0..(NG-2) do

      n1 = 0
      n2 = 0

      n1 = order[child.individuals[j].genes[k]]
      order.delete(n1)

      n2 = order[child.individuals[j].genes[k+1]]

      actual_point[k] = n1
      actual_point[k+1] = n2

      child.individuals[j].value[k] = distance[n1][n2]
    end

    #value配列の最後の要素は最後の点から点１に返る距離
    child.individuals[j].value[NG-1] = distance[ actual_point[NG-1] ][0]

    #puts "actual point of child " + j.to_s + " is"
    #p actual_point

    #value配列の値の総和を取り、それを評価関数（evaluation)の値とする
    for k in 0..(NG-1) do
      child.individuals[j].evaluation += child.individuals[j].value[k]
    end

    #evaluation（評価関数）の逆数（reciprocal)を取る（距離が少ないほど良い＝適合度が高い、ので）
    child.individuals[j].reciprocal = 1 / child.individuals[j].evaluation
  end

  #for j in 0..(NI-1) do
  #  puts "child " + (j+1).to_s + "genes, value, evaluation value is"
  #  p child.individuals[j].genes
  #  p child.individuals[j].value
  #  puts child.individuals[j].reciprocal
  #  puts "\n"
  #end

  #交叉によって生成されたchild群の評価関数（適合度）によるランク付け
  #Make_individualクラスの ranking メソッド使用
  child.ranking(NI, NG, MV, Over, Better)

  #for j in 0..(NI-1) do
  #  puts "child " + (j+1).to_s + "genes, value, evaluation value is"
  #  p child.individuals[j].genes
  #  p child.individuals[j].value
  #  puts child.individuals[j].evaluation
  #  puts "\n"
  #end

  child.elimination(parent, Ways, NI, Better)

  #for j in 0..(NI-1) do
  #  puts "parent " + (j+1).to_s + "genes, value, evaluation value is"
  #  puts parent.individuals[j].evaluation
  #  puts "\n"
  #end

  #parent.show_distribution(child, NI)

  puts "Generation No." + (i+1).to_s + ", result = " + child.individuals[0].evaluation.to_s

end
#交叉、Valueの算出、淘汰のループ終了