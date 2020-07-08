# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  value        :integer          not null
#  user_id      :integer          not null
#  votable_type :string           not null
#  votable_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Vote < ApplicationRecord
  validates :value, :user_id, :votable_id, :votable_type, presence: true

  belongs_to :votable,
    polymorphic: true

  belongs_to :voter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
end
