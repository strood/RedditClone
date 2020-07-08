# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  score      :integer          default(0)
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  subject(:post) do
    build(:post)
  end
  
  # Using shoulda-matchers to do easy validations testing
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:user_id) }
  end

  # Associations
  describe 'associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
    it { should have_many(:posted_subs) }
    it { should have_many(:post_subs) }
    it { should have_many(:votes) }

  end

  # Class methods

  describe 'class methods' do

    describe 'comments_by_parent_id' do
      it 'returns a hash of comments, where keys are parent_comment_id ' do
        expect(post.comments_by_parent_id).to be_an_instance_of(Hash)
      end
    end

  end

end
