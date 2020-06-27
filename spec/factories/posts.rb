# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(word_count: 2) }
    url { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.sentence(word_count: 10) }
    author { User.find_by(username: "tuna") }
  end
end
