# frozen_string_literal: true

module Builders
  module Json
    # builder json message for not found
    class NotFound
      attr_accessor :name

      def initialize(name)
        self.name = name
      end

      def build
        Jbuilder.new do |json|
          json.errors "#{name} not found"
        end.attributes!
      end
    end
  end
end
