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
require 'rails_helper'

RSpec.describe PostSub, type: :model do
  # What to test?
  #  Validations
  #  Associations
  #  Class Methods
  #  Error Messages

  subject(:post_sub) do
    build(:post_sub)
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:sub_id) }
    it { should validate_uniqueness_of(:sub_id).scoped_to(:post_id) }
  end

  # Associations
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:sub) }
  end
end
