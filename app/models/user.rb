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
class User < ApplicationRecord
    attr_reader :password

    validates :username, presence: true, uniqueness: true

    validates :session_token, :password_digest, :session_token, :admin, presence: true

    validates :password, length: { minimum:6, allow_nil: true }


    # Password setter with BCrpyt, and set as digest. Can be verifed for length
    # and will be passed as nil
    def password=(password)
      @password = password
      self.password_digest = BCrypt::Password.create(@password)
    end


    # Checkec password with BCrypt "new"check on its built on is_password method.
    def self.is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def User.find_by_credentials(username, password)
      # return nil unless
    end


end
