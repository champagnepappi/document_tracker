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

users = User.order(:created_at).take(10)
20.times do 
  title = Faker::Book.title
  author = Faker::Name.name
  departments = ["Success", "Life","Sports","Finance","Inspiration","Business"]
  department = departments[rand(6)]
  link = Faker::Internet.url
  content = Faker::Lorem.paragraph
  users.each { |user| user.documents.create!(title: title,
                                             author: author,
                                             department: department,
                                             link: link,
                                             content: content)
  }
end


