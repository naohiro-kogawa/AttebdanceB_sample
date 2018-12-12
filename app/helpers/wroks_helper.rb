module WroksHelper
    # このmoduleではworkが定義されてないので、メソッドに引数を渡してあげる(work)。このメソッドをビューに書くだけです。下のメソッドの処理もコピペしただけです。
    def day_work_time(work)
        work.leaving_time && work.attendance_time && sprintf("%.2f", BigDecimal(((work.leaving_time - work.attendance_time)/60/60).to_s).to_f )
    end
    
    # 以下は一月の計算方法です。
    # def month_work_time(work, year, month)これをビューへ記入。yearとmonthは下のdaysを算出するのに使用する。
    #     total = 0
    #     days = １ヶ月分の日付のオブジェクト
    #     days.each do |day|
    #         if work = Work.find_by(day: day)
    #             total = total + work.leaving_time - work.attendance_time
    #         end
    #     end
    #     totalをsprintfなどを使って調整。
    # end

end
