# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  Sub.destroy_all
  Post.destroy_all
  Comment.destroy_all
  Vote.destroy_all
  UserSub.destroy_all
  PostSub.destroy_all
  Faker::UniqueGenerator.clear

  # Make 100 unique Users
  100.times do
    User.create!(username: Faker::Name.unique.first_name, password:'123456')
  end

  # Make a list of 50 unique Subs
  50.times do
    title = Faker::App.name + " " + Faker::Verb.ing_form + " " + Faker::Food.unique.dish
    Sub.create!(title: title, description: Faker::Lorem.sentence(word_count: 7), user_id: User.find(Faker::Number.between(from:1, to:100)).id)
  end

  # Make 10-20 unique posts in each sub
  (1..50).each do |i|
    Faker::Number.between(from:10, to:20).times do
      title = Faker::Marketing.buzzwords + " " + Faker::Verb.ing_form + " " + Faker::Dessert.flavor
      post = Post.create!(title: title, content: Faker::Lorem.sentence(word_count: 5), user_id: Faker::Number.between(from:1, to:100))
      # Create a PostSub for each post, so each post is added to at least one sub at a time.
      PostSub.create!(post_id: post.id, sub_id: i)
    end
    # Only need to be unique for each sub
    Faker::UniqueGenerator.clear
  end

  # Make 1-3 top level comments, ensure one on each post, so we can nest them more
  # easily knowing all posts will have at least one
  (1..Post.all.length).each do |i|
    Faker::Number.between(from:1, to:3).times do
      Comment.create!(content: Faker::Lorem.sentence(word_count: 8), user_id: Faker::Number.between(from:1, to:100), post_id: i)
    end
  end

  # Make 500 nested first level comments, doing on top post to make easy
  500.times do
    post_id = Faker::Number.between(from:1, to:Post.all.length)
    Comment.create!(content: Faker::Lorem.words(number: 8).join(" "), user_id: Faker::Number.between(from:1, to:100), post_id: post_id, parent_comment_id: Post.find(post_id).comments.first.id)
  end

  # Make nested 2nd level comments
  500.times do
    post_id = Faker::Number.between(from:1, to:Post.all.length)
    comment_id = Faker::Number.between(from:Post.all.length, to:Post.all.length + 500)
    Comment.create!(content: Faker::Lorem.words(number: 8).join(" "), user_id: Faker::Number.between(from:1, to:100), post_id: post_id, parent_comment_id: comment_id)
  end


  # Make Votes
  # Cant have duplicate votes for a user, so need to go through each user and
  # create a couple upvotes, and downvotes for them, keeping it unique to user.
  # so we dont have duplicates, or upvote/downvote collisions

  # Post upvotes and downvotes
  (1..100).each do |user_id|
    Faker::Number.between(from:5, to:10).times do
      # Between 1-5 post upvotes for each user, increment score on post after vote
      vote = Vote.create!(value: 1, user_id: user_id, votable_type: "Post", votable_id: Faker::Number.unique.between(from:1, to:Post.all.length))
      p = Post.find(vote.votable_id)
      p.score += 1
      p.save!
    end
    # Post downvotes
    Faker::Number.between(from:1, to:2).times do
      # Between 1-2 post downvotes for each user, decrement score after vote
      vote = Vote.create!(value: -1, user_id: user_id, votable_type: "Post", votable_id: Faker::Number.unique.between(from:1, to:Post.all.length))
      p = Post.find(vote.votable_id)
      p.score -= 1
      p.save!
    end
    # Only need to be unique for each user, want multiple upvotes on posts if possible
    Faker::UniqueGenerator.clear
  end

  # Comment upvotes and downvotes
  (1..100).each do |user_id|
    Faker::Number.between(from:15, to:20).times do
      # Between 1-5 comment upvotes for each user, increment score on post after vote
      vote = Vote.create!(value: 1, user_id: user_id, votable_type: "Comment", votable_id: Faker::Number.unique.between(from:1, to:Comment.all.length))
      c = Comment.find(vote.votable_id)
      c.score += 1
      c.save!
    end
    # Comment downvotes
    Faker::Number.between(from:1, to:2).times do
      # Between 1-2 comment downvotes for each user, decrement score after vote
      vote = Vote.create!(value: -1, user_id: user_id, votable_type: "Comment", votable_id: Faker::Number.unique.between(from:1, to:Comment.all.length))
      c = Comment.find(vote.votable_id)
      c.score -= 1
      c.save!
    end
    # Only need to be unique for each user, want multiple upvotes on comments if possible
    Faker::UniqueGenerator.clear
  end

  # Make UserSubs
  # Rotate through each user and give them a few subs
  (1..100).each do |i|
    Faker::Number.between(from:1, to:4).times do
      UserSub.create!(user_id: i , sub_id: Faker::Number.unique.between(from:1, to:50))
    end
    Faker::UniqueGenerator.clear
  end

end
