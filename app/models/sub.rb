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
#
class Sub < ApplicationRecord

  validates :title, :description, :user_id, presence: true

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

end
