# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

category = ['Dress', 'Top', 'Knitwear', 'Skirt', 'Pant', 'Jacket', 'Denim', 'Shoes', 'Accessories']
puts 'Creating 10 fake pieces of clothing....'

@user = User.new(email: 'anurag.vashist@gmail.com', password: '123456')
@user.save

10.times do
    garment = Garment.new(
        name:   Faker::Vehicle.model,
        description: Faker::Movie.quote,
        price: Faker::Number.number(digits: 3),
        category: category.sample,
        size: [2,4,6,8,10,12,14].sample,
        colour: Faker::Color.color_name,
        address: Faker::Address.city,
        user_id: 1
    )
    garment.save!
end
puts 'finished'
