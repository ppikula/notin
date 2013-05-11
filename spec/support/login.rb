module Login
  def self.included(base)
    base.before do
      visit '/'
      login_user
    end
  end
end