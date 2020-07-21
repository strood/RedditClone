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
  # What to test?
  #   Validations
  #   Associations
  #   Class Methods
  #   Error Messages

  # Subject to be used for testing, made with factorybot. /factories/users.rb
  subject(:user) do
    build(:user)
  end

  # Using shoulda-matchers to do easy validations testing
  describe 'validations' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:session_token) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_length_of(:password).is_at_least(6) }
  end

  # Associations
  describe 'associations' do
    it { should have_many(:comments) } #comments they are writer of
    it { should have_many(:subs) } #Subs they are the moderator of
    it { should have_many(:posts) } #posts they are the author of
    it { should have_many(:votes) } #votes they are the issuer of
  end

  # Class Methods

  # password=(password)
  it "creates a password_digest when a password is given" do
    expect(user.password_digest).to_not be_nil
  end

  # ensure_session_token
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
        expect(User.find_by_credentials(user.username, "good_pass").username).to eq(user.username)
      end

      it "returns nil if incorrect password given" do
        expect(User.find_by_credentials(user.username, 'bad_password')).to eq(nil)
      end

      it "returns nil if incorrect username given" do
        expect(User.find_by_credentials('bad_username', "bad_pass")).to eq(nil)
      end

    end

    #Reset session token sets a new user session, and returns the new session tokay
    describe 'reset_session_token' do
      it 'generates a new session token for the given user' do
        og_token = user.session_token
        user.reset_session_token
        expect(user.session_token == og_token).to eq(false)
      end
      it 'returns the newly created session token when called.' do
        expect(user.reset_session_token).to eq(user.session_token)
      end
    end

    describe '.pass_valid?(password)' do
      it 'verifies a password is at least 6 characters in length' do
        expect(User.pass_valid?("12345")).to eq(false)
        expect(User.pass_valid?("123456")).to eq(true)
      end
    end

    # Votescore related methods

    describe 'votescore' do
      it 'returns the votescore for the given user' do
        expect(user.votescore).to eq(0)
        expect(user.votescore).to be_an_instance_of(Integer)
      end
    end

    # Subscription method

    describe 'subscription_posts' do
      it 'takes in an array of subscriptions and returns the posts sorted by score' do
        expect(User.subscription_posts(user.subscriptions)).to be_an_instance_of(Array)
      end
    end
  end
end
