module WebToken
    SECRET = Rails.application.secrets.secret_key_base
    EXPIRY = (Time.now + 2.weeks).to_i
    class << self 
        def decode(token)
            JWT.decode(
                token, SECRET, true, {algorithm: "HS256"}
            ).first
        rescue JWT::ExpiredSignature
            :expired
        end
        
        def encode(user)
            jwt = JWT.encode(
                token_params(user),
                SECRET,
                'HS256'
              )
        end

        private

        def token_params(user)
            {
                user_id: user.id, exp: EXPIRY
            }
        end
    end



end