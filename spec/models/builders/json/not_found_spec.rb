# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe 'Builders::Json::NotFound' do
  it { expect(Builders::Json::NotFound.new('Test').build).to_not be_nil }
  it { expect(Builders::Json::NotFound.new('Test').build['errors']).to_not be_empty }
  it { expect(Builders::Json::NotFound.new('Test').build['errors'].length).to eq(1) }
  it { expect(Builders::Json::NotFound.new('Test').build['errors'].first).to eq('Test not found') }
end
