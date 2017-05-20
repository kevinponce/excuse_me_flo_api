# frozen_string_literal: true

require 'rails_helper'
require 'support/generic_support'

RSpec.describe UsersController, type: :controller do
  include GenericSupport

  describe 'valid user' do
    let(:user) { FactoryGirl.attributes_for(:user) }
    before(:each) { post :create, params: { user: user } }

    it { expect(response).to be_success }
    it { expect(body_as_json(response)[:errors]).to be_empty }
    it { expect(body_as_json(response)[:email]).to eq(user[:email]) }
    it { expect(body_as_json(response)[:auth_token]).to_not be_nil }
    it { expect(body_as_json(response)[:refresh_token]).to_not be_nil }
  end

  describe 'invalid user' do
    let(:user) { FactoryGirl.attributes_for(:user, email: 'invalid_email.com') }
    before(:each) { post :create, params: { user: user } }

    it { expect(response).to_not be_success }
    it { expect(body_as_json(response)[:errors]).to_not be_empty }
    it { expect(body_as_json(response)[:email]).to be_nil }
    it { expect(body_as_json(response)[:auth_token]).to be_nil }
    it { expect(body_as_json(response)[:refresh_token]).to be_nil }
  end
end
