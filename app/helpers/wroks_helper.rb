module WroksHelper
    
    # このmoduleではworkが定義されてないので、メソッドに引数を渡してあげる(work)。このメソッドをビューに書くだけです。下のメソッドの処理もコピペしただけです。
    def day_work_time(work)
        work.leaving_time && work.attendance_time && sprintf("%.2f", BigDecimal(((work.leaving_time - work.attendance_time)/60/60).to_s).to_f )
    end
    
    # 以下は一月の計算方法です。
    # ビュー側に@worksの１ヶ月分の勤怠情報があったので、日付情報をヘルパーに使う必要はありませんでした。
    # 引数をworks一つにして、それをeach文にかけて、1日の勤務時間を計算して、足し算していくことで１ヶ月の勤務時間を計算しています。
    # 
     def month_work_time(works) #これをビューへ記入。yearとmonthは下のdaysを算出するのに使用する。
        # totalに一日の勤務時間を順々に足していくイメージです。
         total = 0
        works.each do |work|
             if work.leaving_time && work.attendance_time
                 total = total + (work.leaving_time.to_i - work.attendance_time.to_i)
             end
        end
        # retrunはこのメソッドでsprintf("%.2f", total / 60 / 60)の値を最終的に返すよと明示的に表現しています！
        return sprintf("%.2f", total / 60 / 60)
    #totalをsprintfなどを使って調整。
     end

end
