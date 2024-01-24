require 'faker'

puts 'Destroying old data...'

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all
Follow.destroy_all
FollowRequest.destroy_all

puts 'Seeding new data...'

braden = User.create(name: 'Braden Roth',
                     password: 'password',
                     email: 'bradenr402@gmail.com')

braden.posts.create(body: "Hey everyone! I'm Braden, the creator of this app! I'm a self-taught fullstack Ruby on Rails developer learning how to create web applications through The Odin Project(https://www.theodinproject.com). Check out my GitHub profile at https://github.com/bradenr402 to see more of my projects! And give me a follow if you want to hear about more cool apps I'm creating!")
puts 'Created Braden with 1 post'


ami = User.create(name: 'Ami Roth',
                  password: 'password',
                  email: 'amijoyhamilton@gmail.com')

ami.posts.create(body: 'Hey everyone! My name is Ami! I think you should follow me! :)')
puts 'Created Ami with 1 post'


puts 'Creating users...'
30.times do
  User.create(name: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
end
puts "Created #{User.count} users"


users = User.where.not(id: braden.id).where.not(id: ami.id)
puts "Creating posts..."
users.each do |user|
  rand(2..4).times do
    user.posts.create(body: Faker::Quote.famous_last_words)
  end
end
puts "Created #{Post.count} posts"


posts = Post.all
puts 'Creating comments...'
posts.each do |post|
  rand(2..5).times do
    post.comments.create(body: Faker::Quote.fortune_cookie, user: users.sample)
  end
end
puts "Created #{Comment.count} comments"

puts 'Liking posts...'
posts.each do |post|
  rand(5..15).times do
    users.sample.like(post)
  end
end
puts "Liked posts #{Like.where(likeable_type: 'Post').count} times"


unedited_posts = Post.not_edited.where.not(user_id: braden.id).where.not(user_id: ami.id)
puts 'Editing posts...'
5.times do
  post = unedited_posts.sample
  post.update(body: Faker::Quote.fortune_cookie)
end
puts "Edited #{Post.edited.count} posts"


comments = Comment.all
puts 'Liking comments...'
comments.each do |comment|
  rand(1..10).times do
    users.sample.like(comment)
  end
end
puts "Liked comments #{Like.where(likeable_type: 'Comment').count} times"


puts 'Creating follows...'
45.times do
  follower = users.sample
  followee = users.sample

  followee = users.sample until follower != followee && follower.not_following?(followee)

  follower.follow(followee)
end
puts "Created #{Follow.count} follows"


puts 'Creating follow requests...'
30.times do
  follower = users.sample
  followee = users.sample
  until follower != followee && follower.not_following?(followee) && FollowRequest.where(follower: follower, followee: followee).empty?
    followee = users.sample
  end
  follower.request_to_follow(followee)
end
puts "Created #{FollowRequest.count} follow requests"


puts 'Done!'
