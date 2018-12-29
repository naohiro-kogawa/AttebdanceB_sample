module WroksHelper
  
    def day_work_time(work)
        work.leaving_time && work.attendance_time && sprintf("%.2f", BigDecimal(((work.leaving_time - work.attendance_time)/60/60).to_s).to_f )
    end
    
    def work_count(work)
          work.where.not(attendance_time: nil, leaving_time: nil).count
    end
    
    def month_work_time(works) 
            total = 0
              works.each do |work|
                if work.leaving_time && work.attendance_time
                    total = total + (work.leaving_time.to_i - work.attendance_time.to_i)
                end
              end
                      return sprintf("%.2f", total / 60 / 60)
    end
def specified_time(work)
      if work = User.find(params[:id]).specified_work_time
        sprintf("%.2f", BigDecimal(((work - work.beginning_of_day)/60/60).to_s).to_f )
      end
end
    
    def basic_time(work)
      if work = User.find(params[:id]).basic_work_time
        sprintf("%.2f", BigDecimal(((work - work.beginning_of_day)/60/60).to_s).to_f )
      end
    end
end
