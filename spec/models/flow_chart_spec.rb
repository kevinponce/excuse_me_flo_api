# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlowChart, type: :model do
  let!(:flow_chart) { FactoryGirl.create(:flow_chart) }

  it { expect(flow_chart.errors).to be_empty }
  it { expect(flow_chart.update_attributes(title: nil)).to be_falsey }
  it { expect(flow_chart.update_attributes(markup: nil)).to be_falsey }

  it { expect(FactoryGirl.build(:flow_chart)).to be_valid }

  it { expect(FactoryGirl.build(:flow_chart, title: '')).to be_invalid }
  it { expect(FactoryGirl.build(:flow_chart, title: nil)).to be_invalid }
  it { expect(FactoryGirl.build(:flow_chart, title: 'example')).to be_valid }

  it { expect(FactoryGirl.build(:flow_chart, markup: '')).to be_invalid }
  it { expect(FactoryGirl.build(:flow_chart, markup: nil)).to be_invalid }
  it { expect(FactoryGirl.build(:flow_chart, markup: 'example')).to be_valid }
end
