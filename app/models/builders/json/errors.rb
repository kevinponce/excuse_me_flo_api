# frozen_string_literal: true

module Builders
  module Json
    # builder json message for errors
    class Errors
      attr_accessor :errors

      def initialize(model)
        self.errors = model.errors.full_messages
      end

      def build
        Jbuilder.new do |json|
          json.errors errors
        end.attributes!
      end
    end
  end
end
