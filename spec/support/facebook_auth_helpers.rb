module FacebookAuthHelpers
  def login_user(new_user: false)
    @user = prepare_user(new_user)

    mock_omniauth(@user)

    click_link NotesConstants::LOGIN_TITLE
  end

  # @return [User] user
  def current_user
    @user
  end

  private

  # @param [Boolean] new_user
  # @return [User]
  def prepare_user(new_user)
    if new_user
      user = FactoryGirl.build(:user)
    else
      user = FactoryGirl.create(:user)
    end

    user
  end

  # @param [User] user
  def mock_omniauth(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => user.uid,
        :info => {
            :email => user.email
        }
    })
  end
end