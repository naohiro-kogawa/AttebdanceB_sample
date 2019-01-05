# ユーザー
User.create!(name:  "管理者（菅沼大樹）",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             affiliation: "本社",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               affiliation: "本社",
               activated: true,
               activated_at: Time.zone.now)
end

# 勤怠作成
days = (Date.new(2018,12).all_month)
user = User.find(1)
start_time = Time.new(2018, 5, 30, 9, 00, 00)
end_time = Time.new(2018, 5, 30, 17, 15, 00)
    days.each do |day|
      Work.create!(day: day,
             attendance_time: start_time,
             leaving_time: end_time,
             user_id: user.id)
    end