require 'faker'

puts 'Destroying old data...'

User.destroy_all
Post.destroy_all
Comment.destroy_all

puts 'Seeding new data...'

User.create(name: 'Braden Roth',
            password: 'password',
            email: 'bradenr402@gmail.com')

7.times do
  User.create(name: Faker::Religion::Bible.unique.character,
              password: Faker::Internet.password) do |user|
                user.email = Faker::Internet.email(name: user.name, separators: ['_'], domain: 'wordofgod.net')
                user.posts.build(body: Faker::Religion::Bible.unique.quote)
              end
end

Post.all.each do |post|
  User.all.each do |user|
    post.comments.create(body: Faker::Quote.unique.fortune_cookie) do |comment|
      comment.user = user
    end
  end
  Faker::Quote.unique.clear
end
