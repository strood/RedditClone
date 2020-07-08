# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#  score             :integer          default(0)
#
FactoryBot.define do
  factory :comment do
    content { "My test comment content" }
    user_id { User.first.id }
    post_id { Post.first.id }
  end
end
