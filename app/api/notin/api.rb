module Notin
  class API < Grape::API
    format :json

    helpers Notin::APIHelpers

    mount Notin::Endpoints::Notes
  end
end