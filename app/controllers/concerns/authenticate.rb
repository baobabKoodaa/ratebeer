module Authenticate
  extend ActiveSupport::Concern
def authenticate
  admin_accounts = { "admin" => "secret", "pekka" => "beer", "arto" => "foobar", "matti" => "ittam"}

  authenticate_or_request_with_http_basic do |username, password|
    return true if admin_accounts[username] == password
  end
  return false
end
  end