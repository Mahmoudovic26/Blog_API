# In app/controllers/concerns/tokenable.rb
module Tokenable
    extend ActiveSupport::Concern
  
    def encode_token(payload)
      JsonWebToken.encode(payload)
    end
  end
  
  