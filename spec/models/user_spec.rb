# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin           :boolean          default(FALSE)
#
require 'rails_helper'
require 'rspec/rails'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testting, made with factorybot. /factories/users.rb
  subject(:user) do
    build(:user)
  end

  # Using shoulda-matchers to do easy validations testing
  describe 'validations' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:session_token) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_presence_of(:admin) }
      it { should validate_length_of(:password).is_at_least(6) }
  end

  # Associations


  # Class Methods

  it "creates a password_digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  it "creates a session_token before validation" do
    user.valid?
    expect(user.session_token).to_not be_nil
  end


  describe 'class methods' do
    # Test our password lookup/comparison method
    describe '#is_password?' do
      it "verifies password is correct when hashed and compared against password_digest" do
        expect(user.is_password?('good_pass')).to be true
      end
      it "verifies when password is not correct when compared to digest" do
        expect(user.is_password?('bad_password')).to be false
      end
    end

    # User lookup by username and passwordd, verifies password integrity
    describe 'find_by_credentials' do
      before { user.save! }
      it 'returns user when correct info given' do
        expect(User.find_by_credentials(user.username, user.password))
          .to eq(user)
      end

      it "returns nil if incorrect password given" do
        expect(User.find_by_credentials(user.username, 'bad_password')).to eq(nil)
      end

      it "returns nil if incorrect username given" do
        expect(User.find_by_credentials('bad_username', "bad_pass")).to eq(nil)
      end

    end
  end
end
