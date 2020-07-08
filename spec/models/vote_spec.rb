# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  value        :integer          not null
#  user_id      :integer          not null
#  votable_type :string           not null
#  votable_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Vote, type: :model do
  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testing, made with factorybot. /factories/users.rb
  subject(:vote) do
    build(:vote)
  end

    # Validations
  describe 'validations' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:votable_type) }
    it { should validate_presence_of(:votable_id) }
  end

  # Associations
  describe 'associations' do
    it { should belong_to(:votable) }
    it { should belong_to(:voter) }
  end



end
