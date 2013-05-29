module AuthHelpers
  def login_user(provider, new_user: false)
    @user = prepare_user(new_user, provider)

    mock_omniauth(@user, provider)

    click_link NotesConstants::FACEBOOK_LOGIN_TITLE if provider == :facebook
    click_link NotesConstants::GOOGLE_LOGIN_TITLE if provider == :google_oauth2
  end

  # @return [User] user
  def current_user
    @user
  end

  # @param [User] user
  def mock_omniauth(user, provider)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
        :provider => provider.to_s,
        :uid => user.uid,
        :info => {
            :email => user.email
        }
    })
  end

  private

  # @param [Boolean] new_user
  # @return [User]
  def prepare_user(new_user,provider)
    if new_user
      user = FactoryGirl.build(:user,provider:provider)
    else
      user = FactoryGirl.create(:user,provider:provider)
    end

    user
  end
end