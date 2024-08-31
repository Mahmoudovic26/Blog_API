class JsonWebToken
    ALGORITHM = 'HS256'.freeze
  
    def self.secret_key
      Rails.application.credentials.secret_key_base
    end
  
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key, ALGORITHM)
    end
  
    def self.decode(token)
      decoded_token = JWT.decode(token, secret_key, true, { algorithm: ALGORITHM }).first
      HashWithIndifferentAccess.new(decoded_token)
    rescue JWT::ExpiredSignature
      raise "Token has expired"
    rescue JWT::DecodeError => e
      raise "Invalid token: #{e.message}"
    end
  end
  