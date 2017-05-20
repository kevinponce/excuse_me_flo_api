# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::FlowCharts' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:flow_chart1) { FactoryGirl.create(:flow_chart, user: user, title: 't1', markup: 'm1') }
  let!(:flow_chart2) { FactoryGirl.create(:flow_chart, user: user, title: 't2', markup: 'm2') }

  describe 'without tokens' do
    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build).to_not be_nil }
    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['errors']).to be_empty }
    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['flow_charts'].length).to eq(2) }

    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['flow_charts'][0]['title']).to eq(flow_chart1.title) }
    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['flow_charts'][0]['markup']).to eq(flow_chart1.markup) }

    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['flow_charts'][1]['title']).to eq(flow_chart2.title) }
    it { expect(Builders::Json::FlowCharts.new(user.flow_charts).build['flow_charts'][1]['markup']).to eq(flow_chart2.markup) }
  end
end
