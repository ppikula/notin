require 'spec_helper'

describe 'catch-all route' do
  it 'routes /something-that-doesnt-match to the notin#index' do
    get('/something-that-doesnt-match').should route_to({
        :controller => 'notin',
        :action => 'index',
        :path => 'something-that-doesnt-match'
    })
  end
end