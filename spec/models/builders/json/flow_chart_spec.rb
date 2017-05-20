# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::FlowChart' do
  let!(:flow_chart) { FactoryGirl.create(:flow_chart) }

  describe 'without tokens' do
    it { expect(Builders::Json::FlowChart.new(flow_chart).build).to_not be_nil }
    it { expect(Builders::Json::FlowChart.new(flow_chart).build['errors']).to be_empty }
    it { expect(Builders::Json::FlowChart.new(flow_chart).build['flow_chart']['title']).to eq(flow_chart.title) }
    it { expect(Builders::Json::FlowChart.new(flow_chart).build['flow_chart']['markup']).to eq(flow_chart.markup) }
  end
end
