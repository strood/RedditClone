# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  admin           :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  subject(:user) do
    build(:user)
  end

  describe 'validations' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:session_token) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:admin) }
  end


end
