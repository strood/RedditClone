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
class User < ApplicationRecord
    extend FriendlyId
    friendly_id :username
    validates_format_of :username, :with => /\A[a-z0-9]+\z/i
    validates_length_of :username, maximum: 15
    validates_length_of :password, { minimum: 6, allow_nil: true}

    attr_reader :password

    validates :username, presence: true, uniqueness: true
    validates :password_digest, presence: { message: 'Password can\'t be blank'}
    validates :session_token, :password_digest, presence: true

    # Need to allow blank otherwise false doesnt work as default.
    validates :admin, presence: true, allow_blank: true


    after_initialize :ensure_session_token

    has_many :subs,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :Sub

    has_many :posts,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :Post

    has_many :comments,
      dependent: :destroy

    has_many :votes,
      dependent: :destroy

    has_many :user_subs,
      dependent: :destroy

    has_many :subscriptions,
      through: :user_subs,
      source: :sub


    # (username<str>, passowrd<str>) => User/nil
    # Search for user by indexed username, then verify password
    def User.find_by_credentials(username, password)
      # return nil unless user found, and password is verified
      user = User.find_by(username: username)
      return nil if user.nil?
      user.is_password?(password) ? user : nil
    end

    # Password validation, can add further checks in here if needed
    def User.pass_valid?(password)
      password.length >= 6
    end

    # Password setter with BCrpyt, and set as digest. Can be verifed for length
    # and will be passed as nil
    def password=(password)
      # @password created so we can validate password for various things before
      #  allowing it to be set as password_digest
      @password = password
      self.password_digest = BCrypt::Password.create(@password)
    end


    # Check password with BCrypt "new"check on its built on is_password method.
    def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    # Randomize user session and cleanup cookie token so session cant be hijacked
    def reset_session_token
      self.session_token = User.generate_session_token
      self.save(validate: false)
      self.session_token
    end

    # use SecureRandom to gen a urlsafe session token to use.
    def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
    end

    def votescore
      @votescore ||= self.generate_vote_score
    end

    def generate_vote_score
      @votescore = 0
      self.posts.each { |post| @votescore += post.votes.length }
      self.comments.each { |comment| @votescore += comment.votes.length }
      @votescore
    end

    # Take array of subscruiptions and rank all posts in them by score
    def self.subscription_posts(subscriptions, order)
      @posts = []
      subscriptions.each do |sub|
        @posts += sub.sub_posts.order(order)
      end
      @posts
    end


    private

    def ensure_session_token
      self.session_token ||= User.generate_session_token
    end

end
