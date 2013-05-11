class User < ActiveRecord::Base
  devise :database_authenticatable,:omniauthable,  :omniauth_providers => [:facebook]

  attr_accessible :email, :provider, :uid

  # @param [OmniAuth::AuthHash]
  # @return [User]
  def self.find_or_create_facebook_user(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email)
    end

    user
  end
end
