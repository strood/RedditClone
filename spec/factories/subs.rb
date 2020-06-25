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
FactoryBot.define do
  factory :sub do
    title { Faker::Creature::Animal.name }
    description { Faker::Lorem.sentence(word_count: 5) }
    moderator { User.find_by(username: "tuna") }
  end
end
