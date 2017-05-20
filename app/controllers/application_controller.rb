# frozen_string_literal: true

# application base class
class ApplicationController < ActionController::API
  include KpJwt::Auth
end
