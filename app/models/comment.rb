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
#
class Comment < ApplicationRecord
  validates :content, :user_id, :post_id, presence: true

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :parent_comment,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment,
    optional: true

  has_many :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: :Comment


end
