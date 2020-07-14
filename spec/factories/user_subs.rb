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
FactoryBot.define do
  factory :user_sub do
    user_id { 1 }
    sub_id { 1 }
  end
end
