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
    content { "MyText" }
    user_id { "" }
    post_id { "" }
  end
end
