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
#  slug              :string
#
class Comment < ApplicationRecord
  validates :content, :user_id, :post_id, :slug, presence: true
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

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

  has_many :votes,
    as: :votable

  def slug_candidates
    [
      :content,
      [:content, :post],
      [:content, :post, :author]
    ]
  end

    # Calculate a rating for a comment based on history of all votes on it.
    # Not adapted for (hotness) yet
    # No longer used, but may frame hotness from the idea of it so just preserving
    # def rating
    #   @rating = 0
    #   self.votes.each do |vote|
    #     if vote.value > 0
    #       @rating += 1
    #     else
    #       @rating -= 1
    #     end
    #   end
    #   @rating
    # end

end
