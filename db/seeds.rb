# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(
#   name: 'user1',
#   email: 'user1@example.com',
#   password: 'password'
# )

# Label.create!(name: 'Work')
# Label.create!(name: 'Private')
# Label.create!(name: 'Others')

10.times do |i|
  Label.create!(name: "Label#{i}")
end

10.times do |i|
  User.create!(name: "user#{i}", email: "user#{i}@example.com", password: 'hogehoge')
end

10.times do |i|
  Task.create!(title: "title#{i}", description: "description#{i}", user_id: 2)
end
