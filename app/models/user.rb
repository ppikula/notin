class User < ActiveRecord::Base
  attr_accessible :email, :provider, :uid

  has_many :notes

  devise :database_authenticatable, :omniauthable,  :omniauth_providers => [:facebook]

  acts_as_tagger

  # @param [OmniAuth::AuthHash]
  # @return [User]
  def self.find_or_create_facebook_user(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(provider: auth.provider, uid: auth.uid, email: auth.info.email)
      user.create_sample_notes
    end

    user
  end

  def create_sample_notes
    NotesSeeder::create_samples(self)
  end
end
