# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe FlowChartsController, type: :controller do
  include GenericSupport

  let!(:user) { FactoryGirl.create(:user) }
  let!(:auth_token) { user.create_auth_token }

  describe '#create' do
    describe 'valid' do
      let(:flow_chart) { FactoryGirl.attributes_for(:flow_chart) }

      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        post :create, params: { flow_chart: flow_chart }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart][:title]).to eq(flow_chart[:title]) }
      it { expect(body_as_json(response)[:flow_chart][:markup]).to eq(flow_chart[:markup]) }
    end

    describe 'invalid title' do
      let(:flow_chart) { FactoryGirl.attributes_for(:flow_chart, title: '') }

      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        post :create, params: { flow_chart: flow_chart }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'invalid title' do
      let(:flow_chart) { FactoryGirl.attributes_for(:flow_chart, markup: '') }

      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        post :create, params: { flow_chart: flow_chart }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'no auth token' do
      let(:flow_chart) { FactoryGirl.attributes_for(:flow_chart) }

      before(:each) { post :create, params: { flow_chart: flow_chart } }

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end
  end

  describe '#show' do
    let!(:flow_chart) { FactoryGirl.create(:flow_chart, user: user) }

    describe 'valid' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        get :show, params: { id: flow_chart.id }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart][:title]).to eq(flow_chart[:title]) }
      it { expect(body_as_json(response)[:flow_chart][:markup]).to eq(flow_chart[:markup]) }
    end

    describe 'invalid in' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        get :show, params: { id: flow_chart.id + 1 }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'no auth token' do
      before(:each) { get :show, params: { id: flow_chart.id } }

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end
  end

  describe '#index' do
    let!(:flow_chart1) { FactoryGirl.create(:flow_chart, user: user) }
    let!(:flow_chart2) { FactoryGirl.create(:flow_chart, :other, user: user) }

    describe 'valid' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        get :index
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:flow_charts]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_charts].length).to eq(2) }

      it { expect(body_as_json(response)[:flow_charts][0][:title]).to eq(flow_chart1[:title]) }
      it { expect(body_as_json(response)[:flow_charts][0][:markup]).to eq(flow_chart1[:markup]) }

      it { expect(body_as_json(response)[:flow_charts][1][:title]).to eq(flow_chart2[:title]) }
      it { expect(body_as_json(response)[:flow_charts][1][:markup]).to eq(flow_chart2[:markup]) }
    end

    describe 'no auth token' do
      before(:each) { get :index }

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end
  end

  describe '#update' do
    let!(:flow_chart) { FactoryGirl.create(:flow_chart, user: user) }
    let!(:flow_chart_new) { FactoryGirl.attributes_for(:flow_chart, :flow_chart_new) }

    describe 'valid' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        put :update, params: { id: flow_chart.id, flow_chart: flow_chart_new }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart][:title]).to eq(flow_chart_new[:title]) }
      it { expect(body_as_json(response)[:flow_chart][:markup]).to eq(flow_chart_new[:markup]) }
    end

    describe 'invalid title' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        put :update, params: { id: flow_chart.id, flow_chart: flow_chart_new.merge(title: '') }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'invalid markup' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        put :update, params: { id: flow_chart.id, flow_chart: flow_chart_new.merge(markup: '') }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'no auth token' do
      before(:each) { put :update, params: { id: flow_chart.id, flow_chart: { title: 'new' } } }

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end
  end

  describe '#destroy' do
    let!(:flow_chart) { FactoryGirl.create(:flow_chart, user: user) }
    let!(:flow_chart_new) { FactoryGirl.attributes_for(:flow_chart, :flow_chart_new) }

    describe 'valid' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        delete :destroy, params: { id: flow_chart.id }
      end

      it { expect(response).to be_success }
      it { expect(body_as_json(response)[:errors]).to be_empty }
      it { expect(body_as_json(response)[:flow_charts]).to be_empty }
    end

    describe 'invalid ' do
      before(:each) do
        request.headers['Authorization'] = "JWT #{auth_token}"
        delete :destroy, params: { id: flow_chart.id + 1 }
      end

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end

    describe 'no auth token' do
      before(:each) { delete :destroy, params: { id: flow_chart.id } }

      it { expect(response).to_not be_success }
      it { expect(body_as_json(response)[:errors]).to_not be_empty }
      it { expect(body_as_json(response)[:flow_chart]).to be_nil }
    end
  end
end
