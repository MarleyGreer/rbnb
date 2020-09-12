# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

category = ['Dress', 'Top', 'Knitwear', 'Skirt', 'Pant', 'Jacket', 'Denim', 'Shoes', 'Accessories']

puts 'Adding clothing to database....'

# user = User.create!(email: 'anurag.vashist@gmail.com', password: '123456')
# user_id = user.id

3.times do

    garment = Garment.new(
        name: "Georgina Cassia Shirt",
        description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
        price: Faker::Number.number(digits: 2),
        category: category.sample,
        size: Garment::VALID_SIZES.sample,
        colour: Faker::Color.color_name,
        address: Faker::Address.full_address,
        user: User.first
    )

    file = File.open('db/support/images/shirt.jpg')
    garment.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')

    garment.save!
end

3.times do

    garment = Garment.new(
        name: "Palmer Linen Tee",
        description: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false),
        price: Faker::Number.number(digits: 2),
        category: category.sample,
        size: Garment::VALID_SIZES.sample,
        colour: Faker::Color.color_name,
        address: Faker::Address.full_address,
        user: User.last
    )

    file = File.open('db/support/images/t-shirt.jpg')
    garment.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')

    garment.save!
end

3.times do

    garment = Garment.new(
        name: "Sofia Silk Shirt",
        description: Faker::Lorem.paragraph_by_chars(number: 200, supplemental: false),
        price: Faker::Number.number(digits: 2),
        category: category.sample,
        size: Garment::VALID_SIZES.sample,
        colour: Faker::Color.color_name,
        address: Faker::Address.full_address,
        user: User.first
    )

    file = File.open('db/support/images/lady.jpg')
    garment.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')

    garment.save!
end


