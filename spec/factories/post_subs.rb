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
FactoryBot.define do
  factory :post_sub do
    post_id { 1 }
    sub_id { 1 }
  end
end
