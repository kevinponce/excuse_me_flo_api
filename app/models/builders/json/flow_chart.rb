# frozen_string_literal: true

module Builders
  module Json
    # builder json message for flow chart
    class FlowChart
      attr_accessor :flow_chart

      def initialize(flow_chart)
        self.flow_chart = flow_chart
      end

      def build
        Jbuilder.new do |json|
          json.errors []
          json.flow_chart do
            json.id flow_chart.id
            json.title flow_chart.title
            json.markup flow_chart.markup
          end
        end.attributes!
      end
    end
  end
end
