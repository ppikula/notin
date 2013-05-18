STUBBED_USER = FactoryGirl.create(:user)
module Notin::APIHelpers
  def current_user
    STUBBED_USER
  end
end