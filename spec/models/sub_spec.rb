# == Schema Information
#
# Table name: subs
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#  slug        :string
#
require 'rails_helper'

RSpec.describe Sub, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  subject(:sub) do
    build(:sub)
  end

  # Validations
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end
  # Associations
  describe 'associations' do
    it { should belong_to(:moderator) }
    it { should have_many(:post_subs) }
    it { should have_many(:sub_posts) }

  end

  # Class methods
end
