# frozen_string_literal: true

module Builders
  module Json
    # builder json message for flow charts
    class FlowCharts
      attr_accessor :flow_charts

      def initialize(flow_charts)
        self.flow_charts = flow_charts
      end

      def build
        Jbuilder.new do |json|
          json.errors []
          json.flow_charts(flow_charts) do |flow_chart|
            json.id flow_chart.id
            json.title flow_chart.title
            json.markup flow_chart.markup
          end
        end.attributes!
      end
    end
  end
end
