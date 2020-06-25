# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  moderator   :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Sub < ApplicationRecord

  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
    primary_key: :id,
    foreign_key: :moderator,
    class_name: :User

  validates_associated :user

  has_many :posts

  
end
