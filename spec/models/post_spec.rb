# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
    it { should mave_many(:subs) }
    it { should belong_to(:author) }

  end
  # Class methods
end
