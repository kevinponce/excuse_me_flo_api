# frozen_string_literal: true

module Builders
  module Json
    # builder json object for users
    class User
      attr_accessor :user, :with_tokens

      def initialize(user, with_tokens = false)
        self.user = user
        self.with_tokens = with_tokens
      end

      def build
        Jbuilder.new do |json|
          json.errors []
          json.email user.email

          if with_tokens
            json.auth_token user.create_auth_token
            json.refresh_token user.create_refresh_token
          end
        end.attributes!
      end
    end
  end
end
