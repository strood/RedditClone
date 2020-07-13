# == Schema Information
#
# Table name: comments
#
#  id                :bigint           not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#  score             :integer          default(0)
#  slug              :string
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testing, made with factorybot. /factories/users.rb
  subject(:comment) do
    build(:comment)
  end

  # Validations
  describe 'validaitons' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
  end

  # Associations
  describe 'associations' do
    it { should belong_to(:post) }
    it { should belong_to(:author) }
    it { should have_many(:child_comments) }
    it { should have_many(:votes) }

  end
end
