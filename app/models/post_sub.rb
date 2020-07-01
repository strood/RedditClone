# == Schema Information
#
# Table name: post_subs
#
#  id         :bigint           not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PostSub < ApplicationRecord
  validates :post_id, :sub_id, presence: true
  validates :sub_id, uniqueness: { scope: :post_id }

  belongs_to :post,
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :Post

  validates_associated :post

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub

  validates_associated :sub

end
