module Login
  def self.included(base)
    base.before do
      visit '/'
      login_user(:facebook) 
      #login_user(:google_oauth2) # is provider here irrelevant?
    end
  end
end
