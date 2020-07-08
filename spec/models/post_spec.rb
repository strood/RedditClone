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

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }

  end

  # Associations
  describe 'associations' do
    it { should have_many(:comments) }
    it { should belong_to(:author) }
    it { should have_many(:subs) }

  end
  # Class methods
end
