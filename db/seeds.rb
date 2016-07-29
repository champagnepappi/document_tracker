User.create!(name: "Kevin Einstein",
            email: "kevinochieng548@gmail.com",
            password: "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now)

20.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end
