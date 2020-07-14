# == Schema Information
#
# Table name: user_subs
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserSub < ApplicationRecord
  validates :user_id, :sub_id,  presence: true
  validates :sub_id, uniqueness: { scope: :user_id }

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  validates_associated :subscriber

  belongs_to :sub,
    primary_key: :id,
    foreign_key: :sub_id,
    class_name: :Sub

  validates_associated :sub
end
