# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  slug        :string
#
class Sub < ApplicationRecord
  # Extend FriendlyID for nice URLs, set up slugged name.
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # Sets per-page limits for pagination with Kaminari Gem
  paginates_per 15

  # Validations and Associations
  validates :title, :description, :user_id, :slug, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  validates_associated :moderator

  has_many :post_subs,
    dependent: :destroy

  has_many :sub_posts,
    through: :post_subs,
    source: :post

  has_many :user_subs

  has_many :subscribers,
    through: :user_subs,
    source: :user

end
