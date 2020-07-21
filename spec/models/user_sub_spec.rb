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
  # What to test?
  #  Validations
  #  Associations
  #  Class Methods
  #  Error Messages

  subject(:user_sub) do
    build(:user_sub)
  end

  #Validations
  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:sub_id) }
    it { should validate_uniqueness_of(:sub_id).scoped_to(:user_id) }
  end

  #Associations
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:sub) }
  end
end
