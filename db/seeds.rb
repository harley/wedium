# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

john = Author.create!(username: "johnjacob")
Article.create! title: "john's first post", body: "my thoughts", description: "you know...", author: john
Article.create! title: "i'm confident now", body: "my mind", description: "you know..."
Article.create! title: "hello my fans", body: "my body", description: "you know..."