require 'spec_helper'

describe 'helpers' do
  it 'returns 401 if user is not authenticated' do
    get 'notes'
    response.code.should == '401'
  end
end