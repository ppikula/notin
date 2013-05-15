require 'spec_helper'

describe User do
  include FacebookAuthHelpers

  describe 'finding for facebook authentication' do
    context 'when user exists' do
      it 'returns it' do
        user = FactoryGirl.create(:user)
        auth_hash = mock_omniauth(user)

        User.find_or_create_facebook_user(auth_hash).email.should == user.email
      end
    end

    context 'when user doesnt exist' do
      before do
        @user_attrs = FactoryGirl.build(:user)
        auth_hash = mock_omniauth(@user_attrs)

        @user = User.find_or_create_facebook_user(auth_hash)
      end

      it 'creates it and returns it' do
        @user.email.should == @user_attrs.email
      end

      it 'creates sample notes' do
        Note.count.should == 5
      end
    end
  end
end
