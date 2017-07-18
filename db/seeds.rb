# Creating Users

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

users = User.all

# Creating Wikis

50.times do
  Wiki.create!(
    title: Faker::Lorem.word,
    body: Faker::Lorem.paragraph,
    user: users.sample
  )
end

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
