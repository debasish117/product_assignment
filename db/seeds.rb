# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(email: 'admin@email.com', password: 'password', password_confirmation: "password", username: 'travis', role: 'admin')
user.build_contact(city: Faker::Address.city, country: Faker::Address.country, phone: Faker::PhoneNumber.cell_phone)
user.save!
