class User < ActiveRecord::Base
  devise :database_authenticatable,:omniauthable,  :omniauth_providers => [:facebook]

  attr_accessible :email, :provider, :uid

  # @param [OmniAuth::AuthHash]
  # @return [User]
  def self.find_for_facebook_oauth(auth, _)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email)
    end
    user
  end
end
