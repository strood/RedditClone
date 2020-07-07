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
FactoryBot.define do
  factory :vote do
    value { 1 }
    votable { nil }
  end
end
