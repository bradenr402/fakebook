require 'faker'

puts 'Destroying old data...'

User.destroy_all
Post.destroy_all
Comment.destroy_all

puts 'Seeding new data...'

puts 'Generating users...'
User.create(name: 'Braden Roth',
            password: 'password',
            email: 'bradenr402@gmail.com')

10.times do
  User.create(name: Faker::Name.name,
              # email: Faker::Internet.email(name: name, separators: ['-'], domain: 'gmail.com'),
              password: Faker::Internet.password) do |user|
                user.email = Faker::Internet.email(name: user.name, separators: ['_'], domain: 'gmail.com')
                rand(3..7).times do
                  user.posts.build(body: Faker::Lorem.paragraph_by_chars(number: rand(100..450))) do

                  end
                end
              end
end

puts 'Generating posts...'
User.all.each do |user|
end

puts 'Generating comments...'
Post.all.each do |post|
  User.all.each do |user|
    rand(1..3).times do
      post.comments.create(body: Faker::Lorem.paragraph_by_chars(number: rand(30..100))) do |comment|
        comment.user = user
      end
    end
  end
end
