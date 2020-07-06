# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
class Post < ApplicationRecord
  validates :title, :user_id, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs

  has_many :posted_subs,
    through: :post_subs,
    source: :sub

  has_many :comments

  # Returns a hash of comments, where keys are parent_comment_id, so comments
  #  are grouped according to comment they belong to, making iteration faster
  #  so we dont get N + 1 queries when vieiwpong posts w/ many comments
  def comments_by_parent_id
    @comment_hash  = Hash.new { |h, k| h[k] = [] }
    self.comments.each do |comment|
      @comment_hash[comment.parent_comment_id] << comment
    end
    @comment_hash
  end
end
