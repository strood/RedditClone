# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub        :integer          not null
#  author     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Post, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

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
    it { should validate_presence_of(:sub) }
    it { should validate_presence_of(:author) }

  end

  # Associations
  describe 'associations' do
    it { should have_many(:comments) }
    it { should belong_to(:sub) }
    it { should belong_to(:author) }

  end
  # Class methods
end
