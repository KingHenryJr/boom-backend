class ApplicationController < ActionController::API

#get the super secret password from the ENV file
  def jwt_password
    ENV["JWT_PASSWORD"]
  end

#put the token into JSON
  def token_json(user)
    {
      username: user.username,
      user_id: user.id,
      token: generate_token(user)
    }
  end

#create the token
  def generate_token(user)
    user_id = user.id
    JWT.encode({"user_id": user_id}, jwt_password, 'HS256')
  end

  def valid_token?
    !!try_decode_token
  end

# grab the token from header - decoded token with JWT password
  def try_decode_token

    token = request.headers["Authorization"]

    begin
      decoded = JWT.decode(token, jwt_password, true, { algorithm: 'HS256' })
    rescue JWT::VerificationError
      return nil
    end

      return decoded
  end

# get the current user id using the decoded token
  def current_user_id
    decoded = try_decode_token

    unless decoded && decoded[0] && decoded[0]["user_id"]
      return nil
    end
    return decoded[0]["user_id"]
  end

  #high level authorization! check the decoded user id with table user ID
    def authorized?(user)
      return current_user_id == user.id
    end

end
