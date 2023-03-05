# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)

abdo = User.first_or_create!(email: 'abdo@gmail.com',
                    password: '123456',
                    password_confirmation: '123456',
                    first_name: 'Abdo',
                    last_name: "ahmed",
                    role: User.roles[:admin])
dean = User.first_or_create!(email: 'dean@gmail.com',
            password: '123456',
            password_confirmation: '123456',
            first_name: 'Abdo',
            last_name: "ahmed")


Address.first_or_create!(street: '123 Main St',
              city: 'Anytown',
              state: 'CA',
              zip: '12345',
              country: 'USA',
              user: abdo)
Address.first_or_create(street: '123 Main St',
             city: 'Anytown',
             state: 'CA',
             zip: '12345',
             country: 'USA',
             user: dean)

category = Category.first_or_create!(name:"Uncategorized", display_in_nav: true)
Category.first_or_create!(name:"Cars", display_in_nav: false)
Category.first_or_create!(name:"Bikes", display_in_nav: true)
Category.first_or_create!(name:"Boats", display_in_nav: true)

elapsed=Benchmark.measure do
  articles = []

  100.times do |x|
    puts "creating article number #{x}"
    article = Article.new(title: "Title #{x}",
              body: "Body #{x} Words go here Idk",
              user: abdo,
              category: category)
    articles.push(article)
    2.times do |y|
      puts "creating comment number #{y} for article number #{x} "

       article.comments.build(body: "Comment #{y}",
            user: dean)
    end

  end
  Article.import(articles,recursive: true)
end

puts "Elapsed time is #{elapsed.real} seconds"
