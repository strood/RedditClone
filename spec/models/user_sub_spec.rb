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
require 'rails_helper'

RSpec.describe UserSub, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end