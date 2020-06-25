# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub        :integer          not null
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord

  validates :title, :sub, :author, presence: true

  belongs_to :sub

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author,
    class_name: :User
    
end
