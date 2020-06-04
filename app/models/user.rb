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
    validates :username, presence: true, uniqueness: true

    validates :session_token, :password_digest, :session_token, :admin, presence: true


end
