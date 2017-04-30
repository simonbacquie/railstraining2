class JsonWebToken
  # this is just a nice convenience class to wrap the methods on
  # the JWT gem in the specific way that we're using it

  def self.encode(payload)
    # this uses the Rails app's secret key as defined in secrets.yml,
    # which ultimately gets set in the .env file that Orats uses
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
  rescue
    nil
  end
end
