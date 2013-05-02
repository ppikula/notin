module Notin
  class API < Grape::API
    format :json

    mount Notin::Endpoints::Notes
  end
end